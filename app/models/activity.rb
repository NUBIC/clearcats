# == Schema Information
# Schema version: 20110331204648
#
# Table name: activities
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  description      :text
#  project_id       :integer
#  activity_type_id :integer
#  event_date       :datetime
#  deliverable      :text
#  created_at       :datetime
#  updated_at       :datetime
#

class Activity < ActiveRecord::Base

  belongs_to :project
  belongs_to :activity_type
  
  validates_presence_of :name
  validates_presence_of :activity_type

  has_many :notes, :class_name => "Note", :as => :notable, :dependent => :destroy
  accepts_nested_attributes_for :notes, :allow_destroy => true
  
  has_many :attachments, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :attachments, :allow_destroy => true

  has_many :activity_actors
  accepts_nested_attributes_for :activity_actors, :allow_destroy => true

  named_scope :for_organizational_units, 
    lambda { |org_units| 
      { :joins => "INNER JOIN activity_types ON activity_types.id = activities.activity_type_id INNER JOIN service_lines ON service_lines.id = activity_types.service_line_id", 
        :conditions => ["service_lines.organizational_unit_id IN (:ids)", {:ids => org_units.map(&:id)} ]}
    }

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
