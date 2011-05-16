require 'spec_helper'

describe PublicationsReporter do
  
  it "should return series data for awards by year" do
    @object = Object.new
    @object.extend(PublicationsReporter)

    series_data = @object.publications_summary_by_year
    series_data.should == "[{\"name\":2008,\"data\":0,\"url\":\"/publications/search?search[all_for_reporting_year]=2008\"}," + 
                           "{\"name\":2009,\"data\":0,\"url\":\"/publications/search?search[all_for_reporting_year]=2009\"}," + 
                           "{\"name\":2010,\"data\":0,\"url\":\"/publications/search?search[all_for_reporting_year]=2010\"}," + 
                           "{\"name\":2011,\"data\":0,\"url\":\"/publications/search?search[all_for_reporting_year]=2011\"}]"
  end
  
  
end