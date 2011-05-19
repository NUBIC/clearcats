class AddEffortToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :effort, :integer, :default => 0
    add_column :activities, :cost, :float, :default => 0.0
  end

  def self.down
    remove_column :activities, :cost
    remove_column :activities, :effort
  end
end