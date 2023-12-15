class AddRoleToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :text, default: 'user'
  end
end
