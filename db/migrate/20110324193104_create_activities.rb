class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :name
      t.integer :project_id
      t.integer :activity_type_id
      t.datetime :due_at
      t.text :deliverable

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
