class AddPositionToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :position, :integer
  end

  def self.down
    remove_column :activities, :position
  end
end