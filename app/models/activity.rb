# == Schema Information
# Schema version: 20110429141805
#
# Table name: activities
#
#  id                            :integer         not null, primary key
#  name                          :string(255)
#  description                   :text
#  project_id                    :integer
#  service_line_id               :integer
#  activity_type_id              :integer
#  event_date                    :datetime
#  deliverable                   :text
#  billable                      :boolean
#  created_at                    :datetime
#  updated_at                    :datetime
#  due_date                      :date
#  client_reminder_date          :date
#  client_followup_reminder_date :date
#  staff_reminder_date           :date
#  staff_followup_reminder_date  :date
#

# An activity is a record of a particular interaction between an actor or actors with the CTSA.
class Activity < ActiveRecord::Base

  belongs_to :project
  belongs_to :activity_type
  belongs_to :service_line
  
  validates_presence_of :name
  validates_presence_of :service_line

  has_many :notes, :class_name => "Note", :as => :notable, :dependent => :destroy
  accepts_nested_attributes_for :notes, :allow_destroy => true
  
  has_many :attachments, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :attachments, :allow_destroy => true

  has_many :activity_actors
  accepts_nested_attributes_for :activity_actors, :allow_destroy => true

  scope :for_organizational_units, 
    lambda { |org_unit_ids| 
      joins("INNER JOIN service_lines ON service_lines.id = activities.service_line_id").
      where("service_lines.organizational_unit_id IN (?)", org_unit_ids )
    }

  search_methods :for_organizational_units

  before_save :set_dates_and_reminders

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
  
  def formatted_event_date
    Date.parse(self.event_date.to_s).strftime("%m/%d/%Y") unless self.event_date.blank?
  end
  
  def formatted_event_date=(dt)
    self.event_date = dt
  end
  
  private
  
    def set_dates_and_reminders
      if !activity_type.blank?
        
        if activity_type.has_due_date? && self.due_date.blank?
          self.due_date = Date.today + activity_type.due_in_days_after
        end
        
        if activity_type.has_reminder?
          ActivityType::REMINDERS.each do |reminder|
            reminder_value = activity_type.send(reminder)

            if !reminder_value.blank? && self.send("#{reminder}_date").blank?
              self.send("#{reminder}_date=", self.due_date - reminder_value)
            end
          end
        end
        
      end
    end

end
