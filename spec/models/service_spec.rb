# == Schema Information
# Schema version: 20110429141805
#
# Table name: services
#
#  id              :integer         not null, primary key
#  service_line_id :integer
#  person_id       :integer
#  entered_on      :date
#  state           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  created_by      :string(255)
#  updated_by      :string(255)
#

require 'spec_helper'

describe Service do

  it "should create a new instance given valid attributes" do
    Factory(:service)
  end
  
  it "should describe itself in human readable format" do
    svc = Factory(:service)
    svc.to_s.should == "#{svc.organizational_unit.to_s} service line name"
  end
  
  context "associations" do
    
    it "should delete all orphaned associations upon destroy" do
      
      svc = Factory(:service)
      person = svc.person
      organizational_unit = svc.service_line.organizational_unit
      person.organizational_units.should == [organizational_unit]
      person.services.size.should == 1
      svc.destroy
      
      person = Person.find(person.id)
      person.organizational_units.should be_empty
    end
    
    it "should not remove organizational_unit association if there are more than one services for that person with that organizational unit" do
      org_unit     = Factory(:organizational_unit)
      person       = Factory(:person)
      svc_line_one = Factory(:service_line, :organizational_unit => org_unit, :name => "one")
      svc_line_two = Factory(:service_line, :organizational_unit => org_unit, :name => "two")
      svc_one = Factory(:service, :person => person, :service_line => svc_line_one)
      svc_two = Factory(:service, :person => person, :service_line => svc_line_two)
      
      person.services.size.should == 2
      
      svc_one.destroy
      
      person = Person.find(person.id)
      person.organizational_units.should_not be_empty
      
      svc_two.destroy
      
      person = Person.find(person.id)
      person.organizational_units.should be_empty
    end
    
    describe "activities" do
      
      it "should return an activity if the person is an activity_actor for a matching service line" do
        person   = Factory(:person)
        svc_line = Factory(:service_line, :name => "the service line")
        svc      = Factory(:service, :person => person, :service_line => svc_line)
        activity = Factory(:activity, :service_line => svc_line)
        actor    = Factory(:activity_actor, :person => person, :activity => activity)
        
        svc.activities.should == [activity]
      end
      
    end
    
  end
  
  context "from a service line with associated activity types" do
    
    before(:each) do
      role = Factory(:role, :name => "Client")
      @svc_line = Factory(:service_line, :name => "line")
      # t.client_reminder           4
      # t.client_followup_reminder  1
      # t.staff_reminder            4
      # t.staff_followup_reminder   1
      at1 = Factory(:activity_type, :position => 1, :name => "at1", :service_line => @svc_line, :due_in_days_after => 10)
      at2 = Factory(:activity_type, :position => 2, :name => "at2", :service_line => @svc_line, :due_in_days_after => 20)
      at3 = Factory(:activity_type, :position => 3, :name => "at3", :service_line => @svc_line, :due_in_days_after => 30)
      @person = Factory(:person)
    end
    
    describe "on create" do
      
      it "should create a placeholder activity record for each activity type" do
        @svc_line.activity_types.size.should == 3
        
        svc = Factory(:service, :service_line => @svc_line, :person => @person)
        svc.activities.size.should == 3
      end
      
      it "should set the deadlines for those placeholder activities" do
        svc = Factory(:service, :service_line => @svc_line, :person => @person)
        acts = svc.activities
        acts.size.should == 3
        (0..2).each do |i| 
          pos = i + 1
          expected_due_date = (pos * 10).days.from_now.to_date
          acts[i].activity_type.position.should == pos
          acts[i].due_date.should == expected_due_date
        end
      end
      
    end
    
    describe "on destroy" do
      it "should delete all placeholder activity records" do
        svc = Factory(:service, :service_line => @svc_line, :person => @person)
        svc.activities.size.should == 3
        
        Activity.count.should == 3
        svc.destroy
        Activity.count.should == 0
      end
      
      it "should not delete activity records that are not placeholders (i.e. have an event date)" do
        svc = Factory(:service, :service_line => @svc_line, :person => @person)
        svc.activities.size.should == 3
        
        Activity.count.should == 3
        a = Activity.first
        a.event_date = Time.now
        a.save!
        svc.destroy
        Activity.count.should == 1
      end
    end
    
  end

end
