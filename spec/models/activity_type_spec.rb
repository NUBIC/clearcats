# == Schema Information
# Schema version: 20110429141805
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
#

require 'spec_helper'

describe ActivityType do

  it "should override to_s to show a user friendly representation" do
    at = Factory(:activity_type)
    at.to_s.should == at.name
  end
  
  # it { should validate_presence_of(:service_line) } ON UPDATE
  
  context "with dates and reminders" do
  end
  
end
