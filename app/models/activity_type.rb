# == Schema Information
# Schema version: 20110511175546
#
# Table name: activity_types
#
#  id                       :integer         not null, primary key
#  name                     :string(255)
#  service_line_id          :integer
#  created_at               :datetime
#  updated_at               :datetime
#  created_by               :string(255)
#  updated_by               :string(255)
#  due_in_days_after        :integer
#  client_reminder          :integer
#  client_followup_reminder :integer
#  staff_reminder           :integer
#  staff_followup_reminder  :integer
#  position                 :integer
#  dependent_on_previous    :boolean
#  required                 :boolean
#

# An activity type is a template for activities for a service line/project. 
# An activity type sets dates and reminders for individual activities based on the template.
class ActivityType < ActiveRecord::Base
  
  acts_as_list
  
  REMINDERS = ["client_reminder", "client_followup_reminder", "staff_reminder", "staff_followup_reminder"]
  
  belongs_to :service_line
  
  validates_presence_of :service_line, :on => :update

  validate :reminders_within_due_date
  
  def to_s
    name
  end
  
  def due_to_send_reminder?
    return false unless has_due_date?
    due_date = created_at.to_date + due_in_days_after
    REMINDERS.each do |reminder|
      reminder_value = self.send(reminder)
      reminder_date = due_date - reminder_value
      return true if reminder_date == Date.today
    end
    return false
  end
  
  def due?
    return false unless has_due_date?
    return (created_at.to_date + due_in_days_after) == Date.today
  end

  def has_due_date?
    !due_in_days_after.blank?
  end
  
  def has_reminder?
    REMINDERS.each do |reminder|
      return true if !self.send(reminder).blank?
    end
    return false
  end

  private
    
    # Ensure that the reminders are non-negative
    # and are in a time period less than the length of the activity's due date
    def reminders_within_due_date
      return if due_in_days_after.blank?

      REMINDERS.each do |reminder|
        reminder_value = self.send(reminder)
        
        next if reminder_value.blank?

        if reminder_value < 0 
          errors[:base] = "#{reminder.titleize} cannot be less than zero"
        elsif reminder_value >= due_in_days_after
          errors[:base] = "#{reminder.titleize} cannot be greater than the due date"
        end
      end
    end

end
