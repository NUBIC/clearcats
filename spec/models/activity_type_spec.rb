# == Schema Information
# Schema version: 20110523153829
#
# Table name: activity_types
#
#  id                       :integer         not null, primary key
#  name                     :string(255)
#  service_line_id          :integer
#  created_at               :datetime
#  updated_at               :datetime
#  created_by               :string(255)
#  updated_by               :string(255)
#  due_in_days_after        :integer
#  client_reminder          :integer
#  client_followup_reminder :integer
#  staff_reminder           :integer
#  staff_followup_reminder  :integer
#  position                 :integer
#  dependent_on_previous    :boolean
#  required                 :boolean
#

require 'spec_helper'

describe ActivityType do

  it "should override to_s to show a user friendly representation" do
    at = Factory(:activity_type)
    at.to_s.should == at.name
  end
  
  # it { should validate_presence_of(:service_line) } ON UPDATE
  
  context "with dates and reminders" do
    
    describe "reminders are not greater than the due date" do
      it "cannot have a client reminder greater in days than the length of the due in days attribute" do
        at = Factory.build(:activity_type, :due_in_days_after => 7, :client_reminder => 10)
        at.should_not be_valid
      end

      it "cannot have a client followup reminder greater in days than the length of the due in days attribute" do
        at = Factory.build(:activity_type, :due_in_days_after => 7, :client_followup_reminder => 10)
        at.should_not be_valid
      end
    
      it "cannot have a staff reminder greater in days than the length of the due in days attribute" do
        at = Factory.build(:activity_type, :due_in_days_after => 7, :staff_reminder => 10)
        at.should_not be_valid
      end
    
      it "cannot have a staff followup reminder greater in days than the length of the due in days attribute" do
        at = Factory.build(:activity_type, :due_in_days_after => 7, :staff_followup_reminder => 10)
        at.should_not be_valid
      end
      
      it "should be valid if the reminder is less than the due date" do
        at = Factory.build(:activity_type, :due_in_days_after => 7, :staff_followup_reminder => 1)
        at.should be_valid
      end
      
    end

    describe "reminders are not negative" do
      it "cannot have a negative reminder" do
        at = Factory.build(:activity_type, :due_in_days_after => 7, :client_reminder => -1)
        at.should_not be_valid
      end
    end
    
    describe "having dates and reminders" do
      it "should know if it has a due date" do
        at = Factory.build(:activity_type, :due_in_days_after => 7)
        at.has_due_date?.should be_true
        at = Factory.build(:activity_type, :due_in_days_after => nil)
        at.has_due_date?.should be_false
      end
      
      it "should know if it has reminders" do
        at = Factory.build(:activity_type, :due_in_days_after => 7, :staff_reminder => 1)
        at.has_reminder?.should be_true
        at = Factory.build(:activity_type, :due_in_days_after => 7, :staff_followup_reminder => 1)
        at.has_reminder?.should be_true
        at = Factory.build(:activity_type, :due_in_days_after => 7, :client_reminder => 1)
        at.has_reminder?.should be_true
        at = Factory.build(:activity_type, :due_in_days_after => 7, :client_followup_reminder => 1)
        at.has_reminder?.should be_true
        
        at = Factory.build(:activity_type, :due_in_days_after => 7, :client_reminder => nil, :client_followup_reminder => nil, :staff_reminder => nil, :staff_followup_reminder => nil)
        at.has_reminder?.should be_false
      end
    end
  
    describe "activating a reminder" do
      
      it "should not be due to send a reminder if the due_in_days_after does not exist" do
        at = Factory(:activity_type, :due_in_days_after => nil)
        at.should_not be_due_to_send_reminder
      end
      
      it "should be due to send a reminder the number of days after creation" do
        
        at = Factory(:activity_type, :due_in_days_after => 7, :staff_reminder => 3, :staff_followup_reminder => 1)
        at.should_not be_due_to_send_reminder
        
        Timecop.travel(Time.now + 4.days) do
          at.should be_due_to_send_reminder
        end
        
        Timecop.travel(Time.now + 5.days) do
          at.should_not be_due_to_send_reminder
        end
        
        Timecop.travel(Time.now + 6.days) do
          at.should be_due_to_send_reminder
        end
        
        Timecop.travel(Time.now + 7.days) do
          at.should_not be_due_to_send_reminder
          at.should be_due
        end
    
      end
      
    end
    
  end

  
  
end
