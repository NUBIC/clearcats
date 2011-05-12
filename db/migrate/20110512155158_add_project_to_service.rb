class AddProjectToService < ActiveRecord::Migration
  def self.up
    add_column :services, :project_id, :integer
  end

  def self.down
    remove_column :services, :project_id
  end
end