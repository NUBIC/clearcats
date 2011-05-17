class AddServicesCountToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :services_count, :integer, :default => 0
    
    Person.reset_column_information
    Person.all.each { |per| per.update_attribute(:services_count, per.services.length) }
  end

  def self.down
    remove_column :people, :services_count
  end
end