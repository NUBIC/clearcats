class ServicesController < ApplicationController
  permit :Admin, :User
  before_filter :set_user_organizational_units
  layout proc { |controller| controller.request.xhr? ? nil : 'application'  } 

  def index
    params[:search] ||= Hash.new
    params[:search][:service_line_organizational_unit_id_eq_any] ||= @user_organizational_units.collect(&:id) unless @user_organizational_units.blank?
    params[:search][:created_by_equals] ||= current_user.username
    
    set_person_search_parameters if params[:person_id]
    set_project_search_parameters if params[:project_id]
    
    params[:search][:meta_sort] ||= "created_at.desc"
    
    @search = Service.search(params[:search])
    @services = @search.paginate(:page => params[:page], :per_page => 20)
    
    respond_to do |format|
      format.html # index.html.erb
      format.csv { render :csv => @search.all }
    end
  end

  def new
    @service = Service.new
    @search  = Service.search(:created_by_equals => current_user.username, :completed_on_is_null => true)
    @pending_services = @search.paginate(:page => params[:page], :per_page => 20)
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @service }
    end
  end
  
  def choose_person
    if !params[:search].blank?
      search = {}
      params[:search].each do |k,v|
        search["#{k}_like"] = v unless v.blank?
      end
      people = Person.search(search).all
      faculty = FacultyWebService.locate(params[:search])
      @people = (faculty + people).uniq
    end
    get_service
  end
  
  def choose_service_line
    get_service
    ids = current_user.group_memberships.collect(&:affiliate_ids).flatten.map(&:to_i)
    if ids.blank?
      @organizational_units = OrganizationalUnit.all(:order => :name)
    else
      @organizational_units = OrganizationalUnit.find_by_cc_pers_affiliate_ids(ids).sort_by { |ou| ou.name }
    end
  end
  
  # A service will be created after the user selects either the client or the service line
  # The redirect will be determined by the service
  def create
    if params[:service].blank? or (params[:service][:service_line_id].blank? and params[:service][:person_id].blank?)
      if request.referrer.include?("choose_person")
        flash[:notice] = "You must take some action. Please select a person."
      else
        flash[:notice] = "You must take some action. Please select a service line."
      end
      redirect_to :back
    else
      @service = Service.new(params[:service])

      if @service.save!
        flash[:notice] = 'Service was successfully created.'
        if @service.person.blank? || @service.service_line.blank?
          redirect_to(new_service_path) 
        else
          redirect_to(services_path) 
        end
      else
        render :action => "new"
      end
    end
  end
  
  def edit
    get_service
    @person = @person.amplify if @person
  end
    
  def update
    process_update_request
    flash[:notice] = 'Service was successfully updated.'
    redirect_to(services_path)
  end
  
  def completed
    redirect_to :controller => "services", :action => "my_services"
  end
  
  # DELETE /services/1
  # DELETE /services/1.xml
  def destroy
    @service = Service.find(params.delete(:id))
    person = @service.person
    @service.destroy

    respond_to do |format|
      params.delete(:action)
      flash[:link_notice] = "Service has been deleted. <br />Go to the <a href=#{people_path}>Client List</a> to remove the ctsa reportable field for #{person} if desired."
      format.html { redirect_to(services_url(params)) }
      format.xml  { head :ok }
    end
  end
  
  def close
    url = services_url
    url = "/services/my_services" if request.referrer.include?("my_services")
    get_service
    @service.close!
    flash[:link_notice] = "Service has been closed."
    respond_to do |format|
      format.html { redirect_to(url) }
    end
  end
  
  def activities
    get_service
    @activities = @service.activities
  end
  
  def activity
    get_service
    @activity = Activity.find(params[:activity_id])
  end
  
  def edit_activity
    get_service
    @user_organizational_units = determine_organizational_units_for_user
    @service_lines = ServiceLine.for_organizational_units(@user_organizational_units)
    @activity = Activity.find(params[:activity_id])
    @activity_types = [[@activity.activity_type.to_s, @activity.activity_type_id]]
  end
  
  def update_activity
    get_service
    @activity = Activity.find(params[:activity_id])
    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.json do
          render :json => { :id => @activity.id, :service_id => @service.id, :errors => [] }, :status => :ok
        end
      else
        # TODO: handle exceptions
      end
    end
  end
  
  def new_activity
    get_service
    @user_organizational_units = determine_organizational_units_for_user
    @service_lines = ServiceLine.for_organizational_units(@user_organizational_units)
    @activity_types = [["Choose Service Line First", ""]]
    @activity = Activity.new(:event_date => Date.today, :service_line => @service.service_line, :service => @service)
  end
  
  def create_activity
    get_service
    @activity = Activity.new(params[:activity])
    @activity.activity_actors = [ActivityActor.new(:person => @person, :activity => @activity, :role => Role.client)]
    respond_to do |format|
      if @activity.save
        format.json do
          render :json => { :id => @activity.id, :service_id => @service.id, :errors => [] }, :status => :ok
        end
      else
        # TODO: handle exceptions
      end
    end
    
  end
  
  def destroy_activity
    get_service
    @activity = Activity.find(params[:activity_id])
    @activity.destroy

    flash[:notice] = "Activity has been deleted."
    redirect_to(:controller => "services", :action => "activities", :id => @service.id)
  end
  
  private 
  
    def process_update_request
      get_service
      update_service
      update_client
    end
  
    def get_service
      if params[:id]
        @service = Service.find(params[:id])
      else
        @service = Service.new
      end
      @person = @service.person
    end
    
    def set_user_organizational_units
      @user_organizational_units = determine_org_units_for_user
    end
    
    def update_service
      @service.update_attributes(params[:service]) if params[:service]
    end
    
    def update_client
      attr_params = {}
      # Handle polymorphic person - params key dependent on person class
      [:person, :client, :user].each { |e| attr_params = attr_params.merge(params[e]) unless params[e].blank? }
      if @service.person.nil?
        @service.person = Client.new(attr_params)
      else
        @service.person.update_attributes(attr_params)
      end
    end
  
    def meta_search(params)
      search = {}
      search[:netid_like]     = params[:netid_like]     unless params[:netid_like].blank?
      search[:last_name_like] = params[:last_name_like] unless params[:last_name_like].blank?
      search
    end
  
    def faculty_web_service_search(params)
      search = {}
      search[:netid]     = params[:netid_like]     unless params[:netid_like].blank?
      search[:last_name] = params[:last_name_like] unless params[:last_name_like].blank?
      search
    end
    
    def set_person_search_parameters
      @person = Person.find(params[:person_id])
      params[:search][:person_id_equals] = params[:person_id] 
      params[:search][:person_first_name_like] = @person.first_name
      params[:search][:person_last_name_like] = @person.last_name
    end
    
    def set_project_search_parameters
      @project = Project.find(params[:project_id])
      params[:search][:project_id_equals] = params[:project_id]
    end
  
end