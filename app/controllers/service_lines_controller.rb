class ServiceLinesController < ApplicationController
  permit :Admin
  layout proc { |controller| controller.request.xhr? ? nil : 'application'  }
  
  # GET /service_lines
  # GET /service_lines.xml
  def index
    set_service_lines

    respond_to do |format|
      format.html # index.html.erb
      format.json { 
        render :text => @service_lines.sort_by { |sl| sl.name }.map { |sl| { :id => sl[:id], :label => sl[:name], :value => sl[:id] } }.to_json
      }
      format.xml  { render :xml => @service_lines }
    end
  end

  # GET /service_lines/1
  # GET /service_lines/1.xml
  def show
    @service_line = ServiceLine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @service_line }
    end
  end

  # GET /service_lines/new
  # GET /service_lines/new.xml
  def new
    @user_organizational_units = determine_org_units_for_user
    @service_line = ServiceLine.new
    if @user_organizational_units.size == 1
      @service_line.organizational_unit = @user_organizational_units.first
    end

    respond_to do |format|
      @show_header = false
      format.html # new.html.erb
      format.js do
        @show_header = true
        render "new"
      end
      format.xml  { render :xml => @service_line }
    end
  end

  # GET /service_lines/1/edit
  def edit
    @user_organizational_units = determine_org_units_for_user
    @service_line = ServiceLine.find(params[:id])
  end

  # POST /service_lines
  # POST /service_lines.xml
  def create
    @service_line = ServiceLine.new(params[:service_line])

    respond_to do |format|
      if @service_line.save
        format.html do 
          flash[:notice] = 'Service Line was successfully created.'
          redirect_to(service_lines_url(:search => { :order => "descend_by_created_at" }))
        end
        format.js do
          set_service_lines
          render :update do |page|
            page.replace "service_lines_select", :partial => "/service_lines/select", :locals => {:service_lines => @service_lines, :selected => @service_line.id}
          end
        end
        format.xml  { render :xml => @service_line, :status => :created, :location => @service_line }
      else
        @user_organizational_units = determine_org_units_for_user
        format.html { render :action => "new" }
        format.xml  { render :xml => @service_line.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /service_lines/1
  # PUT /service_lines/1.xml
  def update
    @service_line = ServiceLine.find(params[:id])

    respond_to do |format|
      if @service_line.update_attributes(params[:service_line])
        flash[:notice] = 'Service Line was successfully updated.'
        format.html { redirect_to(service_lines_url(:search => { :order => "descend_by_created_at" })) }
        format.xml  { head :ok }
      else
        @user_organizational_units = determine_org_units_for_user
        format.html { render :action => "edit" }
        format.xml  { render :xml => @service_line.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /service_lines/1
  # DELETE /service_lines/1.xml
  def destroy
    @service_line = ServiceLine.find(params[:id])
    @service_line.destroy

    respond_to do |format|
      format.html { redirect_to(service_lines_url) }
      format.xml  { head :ok }
    end
  end
  
  private 
  
    def set_service_lines
      @user_organizational_units = determine_org_units_for_user

      params[:search] ||= {}
      usr_org_units = @user_organizational_units.blank? ? [] : @user_organizational_units.collect(&:id)
      params[:search][:organizational_unit_id_eq_any] ||= usr_org_units

      @search = ServiceLine.search(params[:search])
      @service_lines = @search.all
    end
end
