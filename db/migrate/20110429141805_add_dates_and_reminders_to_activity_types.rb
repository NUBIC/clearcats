class AddDatesAndRemindersToActivityTypes < ActiveRecord::Migration
  def self.up
    add_column :activity_types, :due_in_days_after, :integer
    add_column :activity_types, :client_reminder, :integer
    add_column :activity_types, :client_followup_reminder, :integer
    add_column :activity_types, :staff_reminder, :integer
    add_column :activity_types, :staff_followup_reminder, :integer
    add_column :activity_types, :position, :integer
    add_column :activity_types, :dependent_on_previous, :boolean
    
    add_column :activities, :due_date, :date
    add_column :activities, :client_reminder_date, :date
    add_column :activities, :client_followup_reminder_date, :date
    add_column :activities, :staff_reminder_date, :date
    add_column :activities, :staff_followup_reminder_date, :date
  end

  def self.down
    remove_column :activity_types, :dependent_on_previous
    remove_column :activity_types, :position
    remove_column :activity_types, :staff_followup_reminder
    remove_column :activity_types, :staff_reminder
    remove_column :activity_types, :client_followup_reminder
    remove_column :activity_types, :client_reminder
    remove_column :activity_types, :due_in_days_after
    
    remove_column :activities, :staff_followup_reminder_date
    remove_column :activities, :staff_reminder_date
    remove_column :activities, :client_followup_reminder_date
    remove_column :activities, :client_reminder_date
    remove_column :activities, :due_date
  end
end