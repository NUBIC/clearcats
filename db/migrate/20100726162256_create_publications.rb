class CreatePublications < ActiveRecord::Migration
  def self.up
    create_table :publications do |t|
      t.string :pmcid
      t.string :pmid
      t.string :nihms_number
      t.date :publication_date
      t.integer :person_id
      t.text :abstract
      t.string :title, :limit => 1000
      t.boolean :nucats_assisted
      t.boolean :edited_by_user
      
      t.timestamps
    end
    add_index :publications, :person_id
  end

  def self.down
    remove_index :publications, :person_id
    drop_table :publications
  end
end