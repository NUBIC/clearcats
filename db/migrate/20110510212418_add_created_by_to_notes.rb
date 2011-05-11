class AddCreatedByToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :created_by, :string
    add_column :notes, :updated_by, :string
  end

  def self.down
    remove_column :notes, :created_by
    remove_column :notes, :updated_by
  end
end