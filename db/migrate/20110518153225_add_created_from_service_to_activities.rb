class AddCreatedFromServiceToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :created_from_service, :boolean, :default => false
  end

  def self.down
    remove_column :activities, :created_from_service
  end
end