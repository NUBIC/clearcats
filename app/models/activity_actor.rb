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

class ActivityActor < ActiveRecord::Base

  set_table_name "activities_people"

  belongs_to :activity
  belongs_to :role
  belongs_to :person

  # validates_presence_of :activity
  validates_presence_of :role
  validates_presence_of :person

  attr_writer :person_select
  
  def person_select
    "#{person.to_s} #{person.netid}" if person
  end

end
