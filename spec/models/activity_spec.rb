# == Schema Information
# Schema version: 20110324204242
#
# Table name: activities
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  project_id       :integer
#  activity_type_id :integer
#  due_at           :datetime
#  deliverable      :text
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe Activity do
  
  it "should create a new instance given valid attributes" do
    act = Factory(:activity)
    act.to_s.should == "#{act.name}"
  end
  
  it { should validate_presence_of(:name) }
  
  it { should validate_presence_of(:project) }
  it { should belong_to(:project) }
  
  it { should validate_presence_of(:activity_type) }
  it { should belong_to(:activity_type) }
  
  it { should have_many(:attachments) }
  
  # it { should have_many(:time_entries) }
end
