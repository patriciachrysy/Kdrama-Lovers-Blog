class AddIndexes < ActiveRecord::Migration[7.1]
  def change
    add_index :posts, :author_id
    add_index :likes, :user
    add_index :likes, :post
    add_index :comments, :user
    add_index :comments, :post
  end
end
