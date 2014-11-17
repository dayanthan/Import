class AddUserModeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_mode, :string
  end
end
