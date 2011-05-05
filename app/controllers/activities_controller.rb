class ActivitiesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create_from_external_source
  before_filter :verify_external_source_authenticity_token, :only => :create_from_external_source
  
  permit :Admin, :User

  def index
    @user_organizational_units = determine_organizational_units_for_user
    
    params[:page] ||= 1
    
    Rails.logger.info("~~~ @user_organizational_units = #{@user_organizational_units.map(&:id)}")
    
    @search = Activity.search(:for_organizational_units => @user_organizational_units.map(&:id))
    @activities = @search.paginate(:select => "DISTINCT activities.*", :page => params[:page], :per_page => 20)
    
    respond_to do |format|
      format.html # index.html.haml
      format.xml { render :xml => @activities }
    end
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

end