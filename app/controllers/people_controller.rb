class PeopleController < ApplicationController
  before_filter :permit_user,  :only => [:index, :directory, :search, :search_results, :versions]
  before_filter :permit_admin, :only => [:upload, :revert]

  def index
    params[:search] ||= {}
    @search = Person.search(params[:search])
    @people = @search.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html # index.html.erb
      format.csv { render :csv => @search.all }
    end
  end
  
  # GET /people/1/edit
  def edit
    determine_person
  end
  
  # PUT /people/1
  # PUT /people/1.xml
  def update
    determine_person

    respond_to do |format|
      if @person.update_attributes(params[:person])
        flash[:notice] = 'Person was successfully updated.'
        format.html { redirect_to(people_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end

  end
  
  def directory
    @people = FacultyWebService.locate(params[:search]) unless params[:search].blank?
  end
  
  def upload
    Person.import_data(params[:file].open, find_or_create_user)
    redirect_to people_path
  end

  # GET /people/search
  def search
    @organizational_unit_id = params[:organizational_unit_id]
  end
  
  # POST /people/search_results
  def search_results
    @organizational_unit_id = params[:organizational_unit_id]
    @redirect_action = params[:redirect_action]
    @people = FacultyWebService.locate(params)
  end

  def versions
    @person = Person.find(params[:id])
    if params[:export]
      send_data(@person.export_versions, :filename => "#{@person.to_s.downcase.gsub(' ', '_')}_versions.csv")
    end
  end
  
  def revert
    revertit(Person)
  end
  
  private
  
    def permit_user
      if !current_user.permit?(:Admin, :User)
        flash[:warning] = "You do not have access to the resource you requested."
        redirect_to :controller => "welcome", :action => "index"
      end
    end
    
    def permit_admin
      if !current_user.permit?(:Admin)
        flash[:warning] = "You do not have access to the resource you requested."
        redirect_to :controller => "welcome", :action => "index"
      end
    end
    
    def determine_person
      if current_user.permit?(:Admin, :User)
        @person = Person.find(params[:id])
      else
        @person = Person.find_by_netid(current_user.username)
      end
    end
  
end