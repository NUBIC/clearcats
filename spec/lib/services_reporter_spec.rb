require 'spec_helper'

describe ServicesReporter do
  
  before(:each) do
    @ou = Factory.create(:organizational_unit)
    @sl = Factory(:service_line, :organizational_unit => @ou)
    Factory(:service, :service_line => @sl)
    @object = Object.new
    @object.extend(ServicesReporter)
  end
  
  it "should return series data for services by year" do
    series_data = @object.services_summary_by_year
    series_data.should == ["[{\"name\":2010,\"data\":[0]},{\"name\":2011,\"data\":[1]}]", "[\"ou\"]"]
  end
  
  it "should return series data for services by organizational unit" do
    series_data = @object.services_summary_by_organizational_unit
    series_data.should == "[{\"name\":\"ou\",\"data\":1,\"url\":\"/services?search[service_line_organizational_unit_id_eq_any][]=#{@ou.id}\"}]"
  end
  
  it "should return series data for shared services" do
    series_data = @object.shared_services_summary
    series_data.should == ["[{\"name\":\"Individual\",\"data\":[1]},{\"name\":\"Shared\",\"data\":[0]}]", "[\"ou\"]"]
  end
  
  it "should return services by percentage for all organizational units" do
    series_data = @object.services_percentage_by_organizational_unit
    series_data.should == "[{\"name\":\"#{@ou.abbreviation}\",\"y\":100.0,\"url\":\"/reports/service_lines_for_organizational_unit?ou=#{@ou.abbreviation}\"}]"
  end
  
  it "should return service lines by percentage for an organizational unit" do
    series_data = @object.service_lines_percentage_by_organizational_unit(@ou)
    series_data.should == "[{\"name\":\"#{@sl.name}\",\"y\":100.0,\"url\":\"/services?search[service_line_name_like]=#{@sl.name}\"}]"
  end
  
end