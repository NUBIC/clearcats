class AddRequiredToActivities < ActiveRecord::Migration
  def self.up
    add_column :activity_types, :required, :boolean
    add_column :activities, :required, :boolean
  end

  def self.down
    remove_column :activities, :required
    remove_column :activity_types, :required
  end
end