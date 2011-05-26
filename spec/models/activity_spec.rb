# == Schema Information
# Schema version: 20110523153829
#
# Table name: activities
#
#  id                            :integer         not null, primary key
#  name                          :string(255)
#  description                   :text
#  service_line_id               :integer
#  activity_type_id              :integer
#  event_date                    :datetime
#  deliverable                   :text
#  billable                      :boolean
#  created_at                    :datetime
#  updated_at                    :datetime
#  due_date                      :date
#  client_reminder_date          :date
#  client_followup_reminder_date :date
#  staff_reminder_date           :date
#  staff_followup_reminder_date  :date
#  required                      :boolean
#  service_id                    :integer
#  position                      :integer
#  created_from_service          :boolean
#  effort                        :integer         default(0)
#  cost                          :float           default(0.0)
#

require 'spec_helper'

describe Activity do
  
  it "should create a new instance given valid attributes" do
    act = Factory(:activity)
    act.to_s.should == "#{act.name}"
  end
  
  it { should validate_presence_of(:name) }
  
  it { should validate_presence_of(:service_line) }
  it { should belong_to(:service_line) }
  it { should belong_to(:service) }
  
  # it { should validate_presence_of(:activity_type) }
  it { should belong_to(:activity_type) }
  
  it { should have_many(:attachments) }
  it { should have_many(:activity_actors) }
  it { should have_many(:people).through(:activity_actors) }
  
  # it { should have_many(:notes) }
  # it { should have_many(:time_entries) }
  
  describe "associating an activity type by name" do
    
    it "should find and associate an activity type by name" do
      act = Factory.build(:activity, :activity_type => nil)
      act.activity_type.should be_nil
      
      at = Factory(:activity_type, :name => "asdf")
      act.activity_type_name = at.name
      
      act.activity_type.should_not be_nil
      act.activity_type.should == at
    end
    
    it "should find and associate an activity type by name" do
      act = Factory.build(:activity, :activity_type => nil)
      act.activity_type.should be_nil
      
      ActivityType.find_by_name("qwer").should be_nil
      act.activity_type_name = "qwer"
      
      act.activity_type.should_not be_nil
      act.activity_type.name.should.eql?("qwer")
      ActivityType.find_by_name("qwer").should_not be_nil
    end
    
  end
  
  describe "associating activities with an organizationl unit" do
    
    before(:each) do
      @org_unit_one  = Factory(:organizational_unit, :name => "ONE", :abbreviation => "1")
      @org_unit_two  = Factory(:organizational_unit, :name => "TWO", :abbreviation => "2")
      
      @service_line  = Factory(:service_line, :organizational_unit => @org_unit_one)
      @activity_type = Factory(:activity_type, :service_line => @service_line)
    end
    
    it "should find all activities for an org unit" do
      act = Factory(:activity, :activity_type => @activity_type, :service_line => @service_line)
      
      Activity.for_organizational_units([@org_unit_one]).should == [act]
      Activity.for_organizational_units([@org_unit_two]).should == []
      Activity.for_organizational_units([@org_unit_one, @org_unit_two]).should == [act]
    end
    
  end
  
  describe "associating an existing activity type with due dates and reminders" do
    
    it "should set those dates on the activity" do
      at = Factory(:activity_type, :due_in_days_after => 7, :client_reminder => 3, :client_followup_reminder => 1, :staff_reminder => 3, :staff_followup_reminder => 1)
    
      act = Factory(:activity, :activity_type => at, :due_date => nil)
      act.due_date.should == 7.days.from_now.to_date
      act.staff_reminder_date.should == 4.days.from_now.to_date
      act.staff_followup_reminder_date.should == 6.days.from_now.to_date
      act.client_reminder_date.should == 4.days.from_now.to_date
      act.client_followup_reminder_date.should == 6.days.from_now.to_date
    end
    
    it "should not update the dates upon subsequent saves" do
      at = Factory(:activity_type, :due_in_days_after => 7, :client_reminder => 3, :client_followup_reminder => 1, :staff_reminder => 3, :staff_followup_reminder => 1)
    
      act = Factory(:activity, :activity_type => at, :due_date => nil)
      one_week = 7.days.from_now.to_date
      act.due_date.should == one_week
      act.staff_reminder_date.should == 4.days.from_now.to_date
      act.staff_followup_reminder_date.should == 6.days.from_now.to_date
      act.client_reminder_date.should == 4.days.from_now.to_date
      act.client_followup_reminder_date.should == 6.days.from_now.to_date
      
      Timecop.travel(Time.now + 1.days) do
        act.save!
        six_days = 6.days.from_now.to_date
        six_days.should == one_week
        act.due_date.should == six_days
        act.staff_reminder_date.should == 3.days.from_now.to_date
        act.staff_followup_reminder_date.should == 5.days.from_now.to_date
        act.client_reminder_date.should == 3.days.from_now.to_date
        act.client_followup_reminder_date.should == 5.days.from_now.to_date
      end
    end
    
    it "should know if it is past due" do
      at = Factory(:activity_type, :due_in_days_after => 14)
      act = Factory(:activity, :activity_type => at, :due_date => nil)
      act.due_date.should == 14.days.from_now.to_date
      act.should_not be_past_due
      
      Timecop.travel(15.days.from_now) do
        act.should be_past_due
      end
    end
    
    it "should return all past due and upcoming" do
      past_due = Factory(:activity, :due_date => 3.days.ago, :event_date => nil)
      upcoming = Factory(:activity, :due_date => 3.days.from_now, :event_date => nil)
      future   = Factory(:activity, :due_date => 14.days.from_now, :event_date => nil)

      Activity.past_due.should == [past_due]
      Activity.upcoming.should == [upcoming]
      
      past_due.update_attribute(:event_date, Date.today)
      Activity.past_due.should be_empty
      
      upcoming.update_attribute(:event_date, Date.today)
      Activity.upcoming.should be_empty
    end
    
    it "should know if it is upcoming" do
      at = Factory(:activity_type, :due_in_days_after => 14)
      act = Factory(:activity, :activity_type => at, :due_date => nil)
      act.due_date.should == 14.days.from_now.to_date
      act.should_not be_upcoming
      
      Timecop.travel(8.days.from_now) do
        act.should be_upcoming
      end
    end
    
    it "should return all upcoming" do
    end

    it "should know if it is required" do
      at = Factory(:activity_type, :required => true)
      act = Factory(:activity, :activity_type => at)
      act.should be_required
    end

    
  end
  
  context "calculating effort" do
    
    it "should convert hours into minutes" do
      act = Factory(:activity)
      act.hours = 1
      act.effort.should == 60
    end
    
    it "should handle minutes as input" do
      act = Factory(:activity)
      act.minutes = 15
      act.effort.should == 15
    end
    
    it "should consider both hours and minutes" do
      act = Factory(:activity)
      act.hours = 1
      act.minutes = 15
      act.effort.should == 75
    end
    
    it "should return effort as hours and minutes" do
      act = Factory(:activity)
      act.effort = 75
      act.hours.should == 1
      act.minutes.should == 15
      
      act.effort = 45
      act.hours.should == 0
      act.minutes.should == 45
      
      act.effort = 120
      act.hours.should == 2
      act.minutes.should == 0
    end
    
  end
  
end
