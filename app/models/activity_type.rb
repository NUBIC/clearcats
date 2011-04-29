# == Schema Information
# Schema version: 20110429141805
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
#

class ActivityType < ActiveRecord::Base
  belongs_to :service_line
  
  validates_presence_of :service_line, :on => :update

  validate :reminders_within_due_date
  
  def to_s
    name
  end
  
  def due_to_send_reminder?
    return false if due_in_days_after.blank?
    due_date = created_at.to_date + due_in_days_after
    ["client_reminder", "client_followup_reminder", "staff_reminder", "staff_followup_reminder"].each do |reminder|
      reminder_value = self.send(reminder)      
      reminder_date = due_date - reminder_value
      return true if reminder_date == Date.today
    end
    return false
  end
  
  def due?
    return false if due_in_days_after.blank?
    return (created_at.to_date + due_in_days_after) == Date.today
  end

  private
    
    # Ensure that the reminders are non-negative
    # and are in a time period less than the length of the activity's due date
    def reminders_within_due_date
      return if due_in_days_after.blank?

      ["client_reminder", "client_followup_reminder", "staff_reminder", "staff_followup_reminder"].each do |reminder|
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
