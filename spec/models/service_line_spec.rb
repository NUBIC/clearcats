# == Schema Information
# Schema version: 20110523153829
#
# Table name: service_lines
#
#  id                     :integer         not null, primary key
#  name                   :string(255)
#  organizational_unit_id :integer
#  created_at             :datetime
#  updated_at             :datetime
#  created_by             :string(255)
#  updated_by             :string(255)
#

require 'spec_helper'

describe ServiceLine do

  it "should override to_s to show a user friendly representation" do
    line = Factory(:service_line)
    line.to_s.should == line.name
  end
  
  it { should belong_to(:organizational_unit) }
  it { should have_many(:services) }
  it { should have_many(:activities) }
  it { should validate_presence_of(:name) }
  
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
    
    it "should return empty associations for a service line without services or activities" do
      svc_line = Factory(:service_line)
      svc_line.services.should == []
      svc_line.activities.should == []
    end
    
    it "should return all services and activities for that service line" do
      @svc0.activities.should == [@act0]
      [@act1, @act2].each { |a| @svc1.activities.should include a }
      [@svc0, @svc1].each { |a| @svc_line.services.should include a }
      [@act0, @act1, @act2].each { |a| @svc_line.activities.should include a }
    end
  
    it "should have a cumulative cost based on the number of activities" do
      @svc_line.cost.should == 0.0
      
      @act1.update_attribute(:cost, 0.25)
      @act2.update_attribute(:cost, 2.70)
      
      @svc1.activities.reload
      @svc_line = ServiceLine.find(@svc_line.id)
      @svc_line.cost.should == 2.95
    end
    
    it "should have a cumulative effort based on the number of activities" do
      @svc_line.effort.should == 0
      
      @act1.update_attribute(:effort, 75)
      @act2.update_attribute(:effort, 250)
      
      @svc1.activities.reload
      @svc_line = ServiceLine.find(@svc_line.id)
      @svc_line.effort.should == 325
      @svc_line.hours.should == 5
      @svc_line.minutes.should == 25
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
