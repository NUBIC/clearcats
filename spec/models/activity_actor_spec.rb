# == Schema Information
# Schema version: 20110331204648
#
# Table name: activities_people
#
#  id          :integer         not null, primary key
#  activity_id :integer
#  role_id     :integer
#  person_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe ActivityActor do
  
  it "should create a new instance given valid attributes" do
    a = Factory(:activity_actor)
  end
  
  it { should validate_presence_of(:activity) }
  it { should belong_to(:activity) }

  it { should validate_presence_of(:role) }
  it { should belong_to(:role) }

  it { should validate_presence_of(:person) }
  it { should belong_to(:person) }

end
