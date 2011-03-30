class CreateKeyMetrics < ActiveRecord::Migration
  def self.up
    create_table :key_metrics do |t|
      t.string :name
      t.text :target
      t.integer :metric_item_id

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
