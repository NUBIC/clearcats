class CreateUniqueIndexForActors < ActiveRecord::Migration
  
  
  add_index :categories_posts, [ :category_id, :post_id ], :unique => true, :name => 'by_category_and_post'
  
end