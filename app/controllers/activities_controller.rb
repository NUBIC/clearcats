class ActivitiesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create_from_external_source
  before_filter :verify_external_source_authenticity_token, :only => :create_from_external_source
  
  permit :Admin, :User

  def index
    @user_organizational_units = determine_organizational_units_for_user
    
    params[:page] ||= 1
    params[:search] ||= Hash.new
    params[:search][:for_organizational_units] ||= @user_organizational_units.map(&:id)
    params[:search][:meta_sort] ||= "updated_at.desc"
    
    set_person_context
    
    @search = Activity.search(params[:search])
    @activities = @search.paginate(:select => select_statement, :page => params[:page], :per_page => 20)
    
    respond_to do |format|
      format.html # index.html.haml
      format.xml { render :xml => @activities }
    end
  end
  
  def past_due
    @user_organizational_units = determine_organizational_units_for_user
    
    params[:page] ||= 1
    params[:search] ||= Hash.new
    params[:search][:for_organizational_units] ||= @user_organizational_units.map(&:id)
    params[:search][:past_due] = true
    
    @search = Activity.search(params[:search])
    @activities = @search.paginate(:select => "DISTINCT activities.*", :page => params[:page], :per_page => 20)
  end
  
  def upcoming
    @user_organizational_units = determine_organizational_units_for_user
    
    params[:page] ||= 1
    params[:search] ||= Hash.new
    params[:search][:for_organizational_units] ||= @user_organizational_units.map(&:id)
    params[:search][:upcoming] = true
    
    @search = Activity.search(params[:search])
    @activities = @search.paginate(:select => "DISTINCT activities.*", :page => params[:page], :per_page => 20)
  end

  def new
    @user_organizational_units = determine_organizational_units_for_user
    @service_lines = ServiceLine.for_organizational_units(@user_organizational_units)
    @activity_types = [["Choose Service Line First", ""]]
    @activity = Activity.new(:event_date => Date.today)

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @activity }
    end
  end

  def create
    @activity = Activity.new(params[:activity])

    respond_to do |format|
      if @activity.save
        flash[:notice] = 'Activity was successfully created.'
        format.html { redirect_to(activities_path) }
        format.xml  { render :xml => @activity, :status => :created, :location => @activity }
      else
        @user_organizational_units = determine_organizational_units_for_user
        @service_lines = ServiceLine.for_organizational_units(@user_organizational_units)
        @activity_types = [["Choose Service Line First", ""]]
        format.html { render :action => "new" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def create_from_external_source
    project = Project.find_by_name(params[:project_title])
    person  = Person.find_by_netid(params[:netid])
    role    = Role.find_by_name(params[:role])

    if person && project && role
      @activity = Activity.new(:project => project, :activity_actor => ActivityActor.create(:person => person, :role => role))

      respond_to do |format|
        if @activity.save
          flash[:notice] = 'Activity was successfully created.'
          format.html { redirect_to(activities_path) }
          format.xml  { render :xml => @activity, :status => :created, :location => @activity }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
        end
      end
    else
      # what to do in this case?
    end
  end
  
  def verify_external_source_authenticity_token
    # checks whether the request comes from a trusted source
    if params[:external_source_authenticity_token].nil?
      handle_unverified_request() 
    end
  end
  
  def edit
    @user_organizational_units = determine_organizational_units_for_user
    @service_lines = ServiceLine.for_organizational_units(@user_organizational_units)
    @activity = Activity.find(params[:id])
    @activity_types = [[@activity.activity_type.to_s, @activity.activity_type_id]]
    
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @activity }
    end
  end
  
  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        flash[:notice] = 'Activity was successfully updated.'
        format.html { redirect_to activities_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private
  
    def select_statement
      select = "DISTINCT activities.*"
      if params[:search][:meta_sort]
        if params[:search][:meta_sort].include?("service_line_name")
          select += ", service_lines.name as service_line_name"
        end
        if params[:search][:meta_sort].include?("activity_type_name")
          select += ", activity_types.name as activity_type_name"
        end
      end
      select
    end
    
    def set_person_context
      unless params[:search][:activity_actors_person_id_equals].blank?
        params[:person_id] = params[:search][:activity_actors_person_id_equals]
      end

      if params[:person_id]
        @person = Person.find(params[:person_id]) 
        params[:search][:activity_actors_person_id_equals] = params[:person_id]
      end
    end

end