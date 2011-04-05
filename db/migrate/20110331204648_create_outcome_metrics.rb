class CreateOutcomeMetrics < ActiveRecord::Migration
  def self.up
    create_table :outcome_metrics do |t|
      t.integer :activity_id
      t.integer :amount
      t.string :name
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :outcome_metrics
  end
end
