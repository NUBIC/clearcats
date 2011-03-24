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

class ActivityActor < ActiveRecord::Base

  
  belongs_to :project
  belongs_to :activity
  belongs_to :role
  belongs_to :person

  validates_presence_of :project
  validates_presence_of :activity
  validates_presence_of :role
  validates_presence_of :person

end
