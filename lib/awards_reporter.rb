module AwardsReporter
  include ApplicationHelper
  
  def awards_summary_by_year
    series_data = []
    [2008, 2009, 2010, 2011].each do |yr|
      series_data << { "name" => yr, "data" => Award.all_for_reporting_year(yr).count, "url" => "#{cc_prefix_path}/awards/search?search[all_for_reporting_year]=#{yr}" }
    end
    series_data.to_json
  end
  
end