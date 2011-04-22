class ActivitiesController < ApplicationController
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
    @activity = Activity.new

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
        format.html { render :action => "new" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @activity = Activity.find(params[:id])

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