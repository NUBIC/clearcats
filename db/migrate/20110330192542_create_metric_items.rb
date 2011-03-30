class CreateMetricItems < ActiveRecord::Migration
  def self.up
    create_table :metric_items do |t|
      t.string :name
      t.string :datatype

      t.timestamps
    end
  end

  def self.down
    drop_table :metric_items
  end
end
