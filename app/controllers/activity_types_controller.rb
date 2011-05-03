class ActivityTypesController < ApplicationController
  permit :Admin, :User #, {:portal => :ClearCATS}
  
  # GET /activity_types
  # GET /activity_types.xml
  def index
    @user_organizational_units = determine_org_units_for_user

    params[:search] ||= {}
    usr_org_units = @user_organizational_units.blank? ? [] : @user_organizational_units.collect(&:id)
    params[:search][:service_line_organizational_unit_id_eq_any] ||= usr_org_units

    @search = ActivityType.search(params[:search])
    @activity_types = @search.all

    respond_to do |format|
      format.html # index.html.erb
      format.json do 
        activity_types = ActivityType.all(:include => :service_line, :conditions => ["service_lines.organizational_unit_id IN (?) AND activity_types.name like ?", determine_org_units_for_user.map(&:id), "#{params[:term]}%"])
        render :text => activity_types.map { |at| { :id => at[:name], :label => at[:name], :value => at[:name] } }.to_json 
      end
      format.xml { render :xml => @activity_types }
    end
  end
  
  def sort
    service_line = ServiceLine.find(params[:id])
    activity_types = service_line.activity_types
    activity_types.each do |at|
      at.position = params['activity_type'].index(at.id.to_s) + 1
      at.save
    end
    render :nothing => true
  end

  # GET /activity_types/1
  # GET /activity_types/1.xml
  def show
    @activity_type = ActivityType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @activity_type }
    end
  end

  # GET /activity_types/new
  # GET /activity_types/new.xml
  def new
    @activity_type = ActivityType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @activity_type }
    end
  end

  # GET /activity_types/1/edit
  def edit
    @activity_type = ActivityType.find(params[:id])
  end

  # POST /activity_types
  # POST /activity_types.xml
  def create
    @activity_type = ActivityType.new(params[:activity_type])

    respond_to do |format|
      if @activity_type.save
        flash[:notice] = 'ActivityType was successfully created.'
        format.html { redirect_to(@activity_type) }
        format.xml  { render :xml => @activity_type, :status => :created, :location => @activity_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @activity_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /activity_types/1
  # PUT /activity_types/1.xml
  def update
    @activity_type = ActivityType.find(params[:id])

    respond_to do |format|
      if @activity_type.update_attributes(params[:activity_type])
        flash[:notice] = 'ActivityType was successfully updated.'
        format.html { redirect_to(@activity_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @activity_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /activity_types/1
  # DELETE /activity_types/1.xml
  def destroy
    @activity_type = ActivityType.find(params[:id])
    @activity_type.destroy

    respond_to do |format|
      format.html { redirect_to(activity_types_url) }
      format.xml  { head :ok }
    end
  end
end
