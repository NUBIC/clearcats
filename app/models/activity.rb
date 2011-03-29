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

class Activity < ActiveRecord::Base

  belongs_to :project
  belongs_to :activity_type
  
  validates_presence_of :name
  validates_presence_of :activity_type

  has_many :attachments, :as => :attachable
  accepts_nested_attributes_for :attachments, :allow_destroy => true

  has_many :activity_actors

  def to_s
    name
  end
  
  def activity_type_name=(name)
    at = ActivityType.find_by_name(name)
    if at.nil?
      at = ActivityType.create(:name => name)
    end
    self.activity_type = at
  end

  def activity_type_name
    activity_type.nil? ? "" : activity_type.to_s
  end

end
