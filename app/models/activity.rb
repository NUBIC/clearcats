# == Schema Information
# Schema version: 20110511175546
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
#  required                      :boolean
#  service_id                    :integer
#  position                      :integer
#

# An activity is a record of a particular interaction between an actor or actors with the CTSA.
class Activity < ActiveRecord::Base

  belongs_to :project
  belongs_to :activity_type
  belongs_to :service_line
  belongs_to :service
  
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

  before_save :build_from_activity_type

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
  
  def formatted_due_date
    formatted_date(due_date)
  end
  
  def formatted_event_date
    formatted_date(event_date)
  end
  
  def formatted_event_date=(dt)
    self.event_date = dt
  end
  
  def past_due?
    due_date < Date.today
  end
  
  def upcoming?
    !past_due? && due_date < 7.days.from_now.to_date
  end
  
  def incomplete?
    event_date.blank?
  end
  
  private
  
    def build_from_activity_type
      if !activity_type.blank?
        
        self.required = activity_type.required
        self.position = activity_type.position
        
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
    
    def formatted_date(dt)
      Date.parse(dt.to_s).strftime("%m/%d/%Y") unless dt.blank?
    end

end
