class AddCompletedOnToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :completed_on, :date
  end

  def self.down
    remove_column :services, :completed_on
  end
end