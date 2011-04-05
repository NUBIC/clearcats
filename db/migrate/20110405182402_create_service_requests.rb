class CreateServiceRequests < ActiveRecord::Migration
  def self.up
    create_table :service_requests do |t|
      t.integer :service_line_id
      t.integer :organizational_unit_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :project
      t.text :abstract

      t.timestamps
    end
  end

  def self.down
    drop_table :service_requests
  end
end
