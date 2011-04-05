class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.integer :project_id
      t.integer :activity_type_id
      t.datetime :event_date
      t.text :deliverable

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
