class CreateActivityActors < ActiveRecord::Migration
  def self.up
    create_table :activity_actors do |t|
      t.integer :project_id
      t.integer :activity_id
      t.integer :role_id
      t.integer :person_id

      t.timestamps
    end
  end

  def self.down
    drop_table :activity_actors
  end
end
