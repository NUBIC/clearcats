class CreateUniqueIndexForActors < ActiveRecord::Migration
  
  def self.up
    add_index :activities_people, [ :activity_id, :role_id, :person_id ], :unique => true, :name => 'activity_role_person_uniq_idx'
  end

  def self.down
    remove_index :activities_people, :name => 'activity_role_person_uniq_idx'
  end
  
end