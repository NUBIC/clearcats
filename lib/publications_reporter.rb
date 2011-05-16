module PublicationsReporter
  
  def publications_summary_by_year
    series_data = []
    [2008, 2009, 2010, 2011].each do |yr|
      series_data << { "name" => yr, "data" => Publication.all_for_reporting_year(yr).count, "url" => "/publications/search?search[all_for_reporting_year]=#{yr}" }
    end
    series_data.to_json
  end
  
end