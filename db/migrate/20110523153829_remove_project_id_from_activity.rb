class RemoveProjectIdFromActivity < ActiveRecord::Migration
  def self.up
    remove_column :activities, :project_id
  end

  def self.down
    add_column :activities, :project_id, :integer
  end
end
