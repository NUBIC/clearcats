class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end
    ["Client", "Staff"].each { |name| Role.create!(:name => name) }
  end

  def self.down
    drop_table :roles
  end
end
