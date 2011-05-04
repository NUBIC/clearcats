class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.integer :organizational_unit_id
      t.integer :service_line_id
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :billable

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
