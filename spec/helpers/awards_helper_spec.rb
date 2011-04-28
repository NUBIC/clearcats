require 'spec_helper'

describe AwardsHelper do

  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(AwardsHelper)
  end

  context "sort helpers" do
    
    it "should create options for sorting" do
      helper.options_for_awards_sort_by_select.should include('Sponsor (ascending)')
      helper.options_for_awards_sort_by_select.should include('ascend_by_sponsor_name')
    end
    
    it "should create sort links for options" do
      person = Factory(:person)
      builder = Award.search(:person_id_equals => person.id)
      helper.awards_sort_by_url_map(builder, {:controller=>"awards", :action=> "index"}).keys.should include('ascend_by_sponsor_name')
      helper.awards_sort_by_url_map(builder, {:controller=>"awards", :action=> "index"})['ascend_by_sponsor_name'].should == "/awards?search[meta_sort]=sponsor_name.asc&search[person_id_equals]=#{person.id}"
    end
    
  end

end
