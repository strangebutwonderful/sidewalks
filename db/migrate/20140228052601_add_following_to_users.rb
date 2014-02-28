class AddFollowingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :following, :boolean, :default => false, :null => false
  end
end
