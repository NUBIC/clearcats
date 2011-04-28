require 'spec_helper'

describe PublicationsHelper do

  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(PublicationsHelper)
  end

  context "sort helpers" do
    
    it "should create options for sorting" do
      helper.options_for_publications_sort_by_select.should include('PMCID (ascending)')
      helper.options_for_publications_sort_by_select.should include('ascend_by_pmcid')
    end
    
    it "should create sort links for options" do
      person = Factory(:person)
      builder = Publication.search(:person_id_equals => person.id)
      helper.publications_sort_by_url_map(builder, {:controller=>"publications", :action=> "index"}).keys.should include('ascend_by_pmcid')
      helper.publications_sort_by_url_map(builder, {:controller=>"publications", :action=> "index"})['ascend_by_pmcid'].should == "/publications?search[meta_sort]=pmcid.asc&search[person_id_equals]=#{person.id}"
    end
    
  end

end