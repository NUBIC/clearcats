# == Schema Information
# Schema version: 20110519160226
#
# Table name: projects
#
#  id                     :integer         not null, primary key
#  name                   :string(255)
#  organizational_unit_id :integer
#  service_line_id        :integer
#  start_at               :datetime
#  end_at                 :datetime
#  billable               :boolean
#  created_at             :datetime
#  updated_at             :datetime
#  completed              :boolean
#

require 'spec_helper'

describe Project do
  
  it "should create a new instance given valid attributes" do
    proj = Factory(:project)
    proj.to_s.should == "#{proj.name}"
  end
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:service_line) }
  it { should validate_presence_of(:organizational_unit) }
  it { should belong_to(:organizational_unit) }
  it { should belong_to(:service_line) }
  it { should have_many(:services) }
  it { should have_many(:activities).through(:services) }
  
  # it { should have_many(:notes) }
  
  context "completed" do
    
    it "should know if it is completed" do
      proj = Factory(:project)
      proj.should_not be_completed

      proj.update_attribute(:completed, true)
      proj.should be_completed
    end
    
    it "should return only active" do
      active = Factory(:project, :completed => false)
      completed = Factory(:project, :completed => true)
      projs = Project.active
      projs.should == [active]
    end
    
    it "should return only active for a particular service line" do
      a_svc_line = Factory(:service_line, :name => "a")
      b_svc_line = Factory(:service_line, :name => "b")
      
      a_active = Factory(:project, :completed => false, :service_line => a_svc_line)
      a_completed = Factory(:project, :completed => true, :service_line => a_svc_line)
      b_active = Factory(:project, :completed => false, :service_line => b_svc_line)
      b_completed = Factory(:project, :completed => true, :service_line => b_svc_line)
      
      projs = Project.active
      projs.should == [a_active, b_active]
      
      projs = Project.active.for_service_line(a_svc_line)
      projs.should == [a_active]
    end
    
    it "should close/complete all activities that are not yet closed" 
    
  end
  
  context "with activities" do
    
    before(:each) do
      @proj = Factory(:project)
      @svc = Factory(:service)
      @svc.project = @proj
      @svc.save!
      @act = Factory(:activity, :service => @svc)
      @actor = Factory(:activity_actor, :activity => @act)
      @svc.activities.reload
    end
    
    it "should have activities through services" do
      @svc.activities.should  == [@act]
      @proj.activities.should == [@act]
    end
    
    it "should have people through the activity's actors" do
      @act.activity_actors.size.should == 1
      @proj.people.should == @act.activity_actors.map(&:person)
    end
    
  end
  
end
