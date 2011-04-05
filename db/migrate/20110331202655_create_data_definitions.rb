class CreateDataDefinitions < ActiveRecord::Migration
  def self.up
    create_table :data_definitions do |t|
      t.string :name
      t.text :definition

      t.timestamps
    end
    
    create_table :data_definitions_key_metrics, :id => false do |t|
      t.integer :key_metric_id
      t.integer :data_definition_id
    end
    
  end

  def self.down
    drop_table :data_definitions_key_metrics
    drop_table :data_definitions
  end
end
