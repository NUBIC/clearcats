class CreateTimeEntries < ActiveRecord::Migration
  def self.up
    create_table :time_entries do |t|
      t.integer :activity_id
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
    
    create_table :people_time_entries do |t|
      t.integer :person_id
      t.integer :time_entry_id
    end
    
  end

  def self.down
    drop_table :time_entries
  end
end
