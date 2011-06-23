module ServicesReporter
  include ApplicationHelper
  include ERB::Util
  
  def services_summary_by_organizational_unit
    series_data = []
    OrganizationalUnit.all.each do |ou|
      series_data << { "name" => ou.abbreviation, "data" => Service.organizational_unit_id_equals(ou.id).count, "url" => "#{cc_prefix_path}/services?search[service_line_organizational_unit_id_eq_any][]=#{ou.id}" }
    end
    series_data.to_json
  end
  
  def services_summary_by_year
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
    [series_data.to_json, categories.to_json]
  end
  
  def shared_services_summary
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
    [series_data.to_json, categories.to_json]
  end
  
  def services_percentage_by_organizational_unit
    raw = {}
    OrganizationalUnit.all.each do |ou|
      raw[ou.abbreviation] = Service.organizational_unit_id_equals(ou.id).count
    end
    total = raw.values.inject { |sum, n| sum + n }
    
    series_data = []
    raw.each { |name, value| series_data << { "name" => name, "y" => round((value.to_f/total.to_f) * 100, 2), "url" => "#{cc_prefix_path}/reports/service_lines_for_organizational_unit?ou=#{name}" } }
    series_data.to_json
  end
  
  def service_lines_percentage_by_organizational_unit(ou)
    raw = {}
    ou.service_lines.each do |sl|
      raw[sl.name] = Service.service_line_id_equals(sl.id).count
    end
    total = raw.values.inject { |sum, n| sum + n }
    
    series_data = []
    raw.each { |name, value| series_data << { "name" => name, "y" => round((value.to_f/total.to_f) * 100, 2), "url" => "#{cc_prefix_path}/services?search[service_line_name_like]=#{name}" } }
    series_data.to_json
  end
  
  def department_percentage_by_organizational_unit(ou)
    raw = {}
    ou.departments_worked_with.each do |name|
      raw[name] = Service.organizational_unit_id_equals(ou.id).department_equals(name).count
    end
    total = raw.values.inject {|sum, n| sum + n }
    
    series_data = []
    raw.each { |name, value| series_data << { "name" => name.gsub("'", ""), "y" => round((value.to_f/total.to_f) * 100, 2), "url" => "/clients?search[organizational_unit_equals]=#{ou.id}&search[department_affiliation_equals]=#{name.gsub("'", "")}" } }
    series_data.to_json
  end
  
  private
  
    def round(num, to)
      div = 10**to
      (num * div).round.to_f / div
    end
  
end