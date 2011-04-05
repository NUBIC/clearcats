class CreateTargetMetrics < ActiveRecord::Migration
  def self.up
    create_table :target_metrics do |t|
      t.string :name
      t.text :description
      t.string :datatype
      t.integer :number

      t.timestamps
    end
  end

  def self.down
    drop_table :target_metrics
  end
end
