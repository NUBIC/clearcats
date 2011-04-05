class CreateKeyMetrics < ActiveRecord::Migration
  def self.up
    create_table :key_metrics do |t|
      t.string :name
      t.integer :organizational_unit_id
      t.integer :target_metric_id
      
      t.string :datatype
      t.text :note

      t.timestamps
    end
    
    create_table :key_metrics_projects, :id => false do |t|
      t.integer :key_metric_id
      t.integer :project_id
    end
  end

  def self.down
    drop_table :key_metrics_projects
    drop_table :key_metrics
  end
end
