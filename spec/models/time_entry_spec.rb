# == Schema Information
# Schema version: 20110429141805
#
# Table name: time_entries
#
#  id          :integer         not null, primary key
#  activity_id :integer
#  start_at    :datetime
#  end_at      :datetime
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe TimeEntry do
  
  it "should create a new instance given valid attributes" do
    t = Factory(:time_entry)
  end
  
  it { should validate_presence_of(:start_at) }
  it { should belong_to(:activity) }
  
  it { should have_and_belong_to_many(:people) }
end
