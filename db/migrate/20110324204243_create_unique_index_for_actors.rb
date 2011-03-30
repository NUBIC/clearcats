class CreateUniqueIndexForActors < ActiveRecord::Migration
  
  def self.up
    add_index :activity_actors, [ :project_id, :activity_id, :role_id, :person_id ], :unique => true, :name => 'project_activity_role_person_uniq_idx'
  end

  def self.down
    remove_index :activity_actors, :name => 'project_activity_role_person_uniq_idx'
  end
  
end