class AddServiceToActivity < ActiveRecord::Migration
  def self.up
    add_column :activities, :service_id, :integer
  end

  def self.down
    remove_column :activities, :service_id
  end
end