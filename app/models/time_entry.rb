# == Schema Information
# Schema version: 20110519160226
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

class TimeEntry < ActiveRecord::Base

  belongs_to :activity
  has_and_belongs_to_many :people

  validates_presence_of :start_at

end
