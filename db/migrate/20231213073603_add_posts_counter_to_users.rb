class AddPostsCounterToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :posts_counter, :integer, default: 0
  end
end
