# == Schema Information
# Schema version: 20110324204242
#
# Table name: activity_actors
#
#  id          :integer         not null, primary key
#  project_id  :integer
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

  it { should validate_presence_of(:project) }
  it { should belong_to(:project) }

  it { should validate_presence_of(:role) }
  it { should belong_to(:role) }

  it { should validate_presence_of(:person) }
  it { should belong_to(:person) }

end
