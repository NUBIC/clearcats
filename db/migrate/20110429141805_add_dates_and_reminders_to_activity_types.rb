class AddDatesAndRemindersToActivityTypes < ActiveRecord::Migration
  def self.up
    add_column :activity_types, :due_in_days_after, :integer
    add_column :activity_types, :client_reminder, :integer
    add_column :activity_types, :client_followup_reminder, :integer
    add_column :activity_types, :staff_reminder, :integer
    add_column :activity_types, :staff_followup_reminder, :integer
    add_column :activity_types, :position, :integer
    add_column :activity_types, :dependent_on_previous, :boolean
  end

  def self.down
    remove_column :activity_types, :dependent_on_previous
    remove_column :activity_types, :position
    remove_column :activity_types, :staff_followup_reminder
    remove_column :activity_types, :staff_reminder
    remove_column :activity_types, :client_followup_reminder
    remove_column :activity_types, :client_reminder
    remove_column :activity_types, :due_in_days_after
  end
end