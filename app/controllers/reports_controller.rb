class ReportsController < ApplicationController
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
    series_data = []
    OrganizationalUnit.all.each do |ou|
      series_data << { "name" => ou.abbreviation, "data" => Service.organizational_unit_id_equals(ou.id).count, "url" => "/services?search[service_line_organizational_unit_id_eq_any][]=#{ou.id}" }
    end
    @series_data = series_data.to_json
  end

  def services_by_year_graph
    series_data = []
    categories = []
    yrs = [2010, 2011]
    yrs.each { |yr| series_data << { "name" => yr, "data" => [] } }
    
    OrganizationalUnit.all.each do |ou|
      yrs.each do |yr|
        series_data[yrs.index(yr)]["data"] << Service.organizational_unit_id_equals(ou.id).for_year(yr).count
      end
      categories << ou.abbreviation
    end
    @series_data = series_data.to_json
    @categories = categories.to_json
  end
  
  def shared_services_graph
    series_data = []
    categories = []
    series = ['Individual', 'Shared']
    series.each { |s| series_data << { "name" => s, "data" => [] } }
    
    OrganizationalUnit.all.each do |ou|
      shared_count = Service.shared_with_other_organizational_unit(ou.id).uniq.count
      total_count  = Service.organizational_unit_id_equals(ou.id).uniq.count
      series_data[0]["data"] << (total_count - shared_count)
      series_data[1]["data"] << shared_count
      categories << ou.abbreviation
    end
    @series_data = series_data.to_json
    @categories = categories.to_json
  end
  
  # TODO: by quarter

  # publications
  
  def publications_by_year_graph
    series_data = []
    [2008, 2009, 2010, 2011].each do |yr|
      series_data << { "name" => yr, "data" => Publication.all_for_reporting_year(yr).count, "url" => "/publications/search?search[all_for_reporting_year]=#{yr}" }
    end
    @series_data = series_data.to_json
  end
  
  # awards 
  
  def awards_by_year_graph
    series_data = []
    [2008, 2009, 2010, 2011].each do |yr|
      series_data << { "name" => yr, "data" => Award.all_for_reporting_year(yr).count, "url" => "/awards/search?search[all_for_reporting_year]=#{yr}" }
    end
    @series_data = series_data.to_json
  end

end