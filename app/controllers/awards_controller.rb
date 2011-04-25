class AwardsController < ApplicationController
  before_filter :permit_user,  :only => [:versions]
  before_filter :permit_admin, :only => [:revert]
  before_filter :scope_to_person, :only => [:index]
  layout proc { |controller| controller.request.xhr? ? nil : 'application'  } 

  def index
    if params[:person_id]
      @show_header = true
      
      params[:view_all] = true if faculty_member?
      
      params[:search][:project_period_end_date_greater_than] = Date.new(SYSTEM_CONFIG["ctsa_base_line_year"].to_i,1,1) if params[:view_all].blank?
      params[:search][:meta_sort] ||= "project_period_start_date.desc"
      
      populate_service_and_person
      FacultyWebService.awards_for_employee({:employeeid => @person.employeeid}) unless @person.employeeid.blank?
      
      @search = Award.search(@search_params)
      @awards = @search.all
      respond_to do |format|
        format.html { request.xhr? ?  (render :partial => 'awards/list', :locals => {:awards => @awards, :person => @person, :search => @search_params, :service => nil}) : (render 'index') }
      end
    else
      flash[:notice] = "Awards can be viewed only in the context of a person."
      redirect_to people_path
    end
  end

  def search
    params[:search] ||= Hash.new
    
    params[:search].delete(:invalid_for_ctsa) unless params[:search][:invalid_for_ctsa].to_i == 1
    purge_search_params
    populate_common
    
    @search = Award.search(@search_params)
    @awards = @search.paginate(:page => params[:page], :per_page => 20)
    
    respond_to do |format|
      format.html 
      format.csv { render :csv => @search.all }
    end
  end

  def details
    @award = Award.find(params[:id])
  end

  def new
    populate_common
    @award = Award.new(:person_id => @person.id)
  end

  # GET /awards/edit
  def edit
    populate_common
    @award = Award.find(params[:id])
  end
  
  def create
    @search_params  = params[:search_params]
    @award          = Award.new(params[:award])
    populate_common

    respond_to do |format|
      if @award.save
        format.js do
          @search = Award.search(params[:search])
          @awards = @search.all
          render :update do |page|
            page.replace "awards", :partial => "/awards/list", :locals => { :search => params[:search] }
          end
        end
        format.html do 
          flash[:notice] = "Award was successfully created."
          redirect_to edit_award_url(@award)
          return
        end
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  # POST /awards
  def update
    populate_service_and_person
    @award = Award.find(params[:id])
    respond_to do |format|
      if @award.update_attributes(params[:award])
        format.html do 
          flash[:notice] = "Award was successfully updated."
          redirect_to edit_award_url(@award)
          return
        end
        format.json do          
          Rails.logger.error("~~~ AwardsController#update for #{@award.id}")
          person_id = @person.nil? ? @award.person_id : @person.id
          render :json => { :id => @award.id, :person_id => person_id, :search_params => params[:search], :errors => [] }, :status => :ok
        end
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def row
    populate_service_and_person
    @award = Award.find(params[:id])
  end
  
  # POST /update_ctsa_reporting_year
  def update_ctsa_reporting_year
    populate_service_and_person
    current_year = current_ctsa_reporting_year
    @person.awards.each do |award|
      reporting_years = award.ctsa_reporting_years
      if !params["award_ids"].blank? and params["award_ids"].include?(award.id.to_s)
        if !reporting_years.include?(current_year)
          award.ctsa_reporting_years = (reporting_years << current_year) 
          award.save
        end
      elsif reporting_years.include?(current_year)
        reporting_years.delete(current_year)
        award.ctsa_reporting_years = reporting_years
        award.save
      end
    end
    flash[:notice] = "Awards were updated successfully"
    if faculty_member?
      redirect_to person_publications_path(@person)
    else
      redirect_to person_awards_path(@person) # TODO: determine if there was a service and redirect appropriately
    end
  end
  
  def versions
    @award = Award.find(params[:id])
    send_data(@award.export_versions, :filename => "award_#{@award.id}_versions.csv") if params[:export]
  end
  
  def revert
    revertit(Award)
  end
  
  def incomplete
    params[:search] ||= {}
    params[:search][:invalid_for_ctsa] = true
    @search = Award.search(params[:search])
    @awards = @search.paginate(:page => params[:page], :per_page => 20)
  end
  
  private
  
    def populate_common
      populate_service_and_person
      @show_header    = request.xhr?
      @non_phs_orgs   = NonPhsOrganization.all(:order => :code)
      @phs_orgs       = PhsOrganization.all(:order => :code)
      @activity_codes = ActivityCode.all(:order => :code)
    end
    
    def populate_service_and_person
      @search_params  = params[:search]
      if params[:service_id]
        @service = Service.find(params[:service_id])
        @person  = @service.person
      elsif params[:person_id]
        determine_person(:person_id, false)
      end
    end
    
    def scope_to_person
      params[:search] ||= Hash.new
      params[:search][:person_id_equals] = params[:person_id] if !params[:person_id].blank? and params[:search][:person_id_equals].blank?
      params[:person_id] = params[:search][:person_id_equals] if !params[:search][:person_id_equals].blank? and params[:person_id].blank?
    end
  
end