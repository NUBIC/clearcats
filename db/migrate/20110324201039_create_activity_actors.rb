class CreateActivityActors < ActiveRecord::Migration
  def self.up
    create_table :activities_people do |t|
      t.integer :activity_id
      t.integer :role_id
      t.integer :person_id

      t.timestamps
    end
  end

  def self.down
    drop_table :activities_people
  end
end
