class RemovePostsCounterFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :posts_counter, :integer
  end
end
