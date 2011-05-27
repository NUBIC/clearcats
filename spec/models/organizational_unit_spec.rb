# == Schema Information
# Schema version: 20110523153829
#
# Table name: organizational_units
#
#  id                           :integer         not null, primary key
#  name                         :string(255)
#  abbreviation                 :string(255)
#  parent_id                    :integer
#  lft                          :integer
#  rgt                          :integer
#  created_at                   :datetime
#  updated_at                   :datetime
#  cc_pers_affiliate_identifier :string(255)
#  created_by                   :string(255)
#  updated_by                   :string(255)
#

require 'spec_helper'
require 'pers/affiliate'

describe OrganizationalUnit do
  it "should create a new instance given valid attributes" do
    ou = Factory(:organizational_unit)
    ou.to_s.should == "#{ou.name} (#{ou.abbreviation})"
  end

  it "should locate records from pers::affiliate abbreviations" do
    abbrev = "asdf"
    ou = Factory(:organizational_unit, :cc_pers_affiliate_identifier => abbrev)
    Pers::Affiliate.stub(:all).and_return([mock_model(Pers::Affiliate, :name_abbrev => abbrev)])
    OrganizationalUnit.find_by_cc_pers_affiliate_ids([37]).should == [ou]
  end
  
  it { should have_and_belong_to_many(:people) }
  it { should have_and_belong_to_many(:contacts) }
  
  it { should belong_to(:parent) }
  it { should have_many(:children) }
  it { should have_many(:service_lines) }
  it { should have_many(:contact_lists) }
  it { should have_many(:projects) }


  describe "services, projects, and activities" do
    
    before(:each) do
      @person   = Factory(:person)
      @org_unit = Factory(:organizational_unit)
      @svc_line = Factory(:service_line, :name => "the service line", :organizational_unit => @org_unit)
      @svc0     = Factory(:service, :person => @person, :service_line => @svc_line)
      @svc1     = Factory(:service, :person => @person, :service_line => @svc_line)
      @act0     = Factory(:activity, :service_line => @svc_line, :service => @svc0, :event_date => nil)
      @act1     = Factory(:activity, :service_line => @svc_line, :service => @svc1, :event_date => nil)
      @act2     = Factory(:activity, :service_line => @svc_line, :service => @svc1, :event_date => nil)
      @actor    = Factory(:activity_actor, :person => @person, :activity => @activity)
      @svc0.activities.reload
      @svc1.activities.reload
    end
    
    it "should return empty associations for an org unit without services or activities" do
      org_unit = Factory(:organizational_unit)
      org_unit.services.should == []
      org_unit.activities.should == []
    end
    
    it "should return all services and activities for that organizational unit" do
      @svc0.activities.should == [@act0]
      @svc1.activities.should == [@act1, @act2]
      @org_unit.services.should == [@svc0, @svc1]
      @org_unit.activities.should == [@act0, @act1, @act2]
    end
  
    it "should have a cumulative cost based on the number of activities" do
      @org_unit.cost.should == 0.0
      
      @act1.update_attribute(:cost, 0.25)
      @act2.update_attribute(:cost, 2.70)
      
      @svc1.activities.reload
      @org_unit = OrganizationalUnit.find(@org_unit.id)
      @org_unit.cost.should == 2.95
    end
    
    it "should have a cumulative effort based on the number of activities" do
      @org_unit.effort.should == 0
      
      @act1.update_attribute(:effort, 75)
      @act2.update_attribute(:effort, 250)
      
      @svc1.activities.reload
      @org_unit = OrganizationalUnit.find(@org_unit.id)
      @org_unit.effort.should == 325
      @org_unit.hours.should == 5
      @org_unit.minutes.should == 25
      
    end
    
    it "should know the total number of completed and active activities" do
      @org_unit.activities.active.count.should == 3
      @org_unit.activities.complete.count.should == 0
      
      @act1.close!
      @svc1.activities.reload
      @org_unit = OrganizationalUnit.find(@org_unit.id)
      @org_unit.activities.active.count.should == 2
      @org_unit.activities.complete.count.should == 1
    end
    
  end
  

end
