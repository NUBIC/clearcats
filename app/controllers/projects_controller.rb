class ProjectsController < ApplicationController
  permit :Admin, :User
  before_filter :set_organizational_units_for_user

  def index
    params[:page] ||= 1
    @search = Project.search(:organizational_unit_id_eq_any => @user_organizational_units.map(&:id))
    @projects = @search.paginate(:page => params[:page], :per_page => 20)
    
    respond_to do |format|
      format.html # index.html.haml
      format.xml { render :xml => @projects }
    end
  end

  def new
    @project = Project.new
    @project.organizational_unit = @user_organizational_units.first if @user_organizational_units.size == 1

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @project }
    end
  end

  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to projects_path }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @project }
    end
  end
  
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to projects_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end  
  
  private
  
    def set_organizational_units_for_user
      @user_organizational_units = determine_organizational_units_for_user
    end

end