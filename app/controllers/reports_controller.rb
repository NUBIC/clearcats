class ReportsController < ApplicationController
  include AwardsReporter
  include PublicationsReporter
  include ServicesReporter
  permit :Admin
  
  def index
  end

  def client_list
    params[:search] ||= Hash.new
    @user_organizational_units = determine_org_units_for_user
    @search = Client.search(params[:search])
    @clients = @search.paginate(:page => params[:page], :per_page => 20)
    respond_to do |format|
      format.html # index.html.erb
      format.csv { render :csv => @search.all }
    end
  end
  
  # services
  
  def services_graph
    @series_data = services_summary_by_organizational_unit
  end
  
  def services_pie_chart
    @series_data = services_percentage_by_organizational_unit
  end
  
  def service_lines_for_organizational_unit
    @series_data = service_lines_percentage_by_organizational_unit(OrganizationalUnit.find_by_abbreviation(params[:ou]))
  end

  def services_by_year_graph
    @series_data, @categories = services_summary_by_year
  end
  
  def shared_services_graph
    @series_data, @categories = shared_services_summary
  end
  
  # TODO: by quarter

  # publications
  
  def publications_by_year_graph
    @series_data = publications_summary_by_year
  end
  
  # awards 
  
  def awards_by_year_graph
    @series_data = awards_summary_by_year
  end

end