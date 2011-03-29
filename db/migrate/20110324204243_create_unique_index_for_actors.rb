class CreateUniqueIndexForActors < ActiveRecord::Migration
  
  add_index :activity_actors, [ :project_id, :activity_id, :role_id, :person_id ], :unique => true, :name => 'project_activity_role_person_uniq_idx'
  
end