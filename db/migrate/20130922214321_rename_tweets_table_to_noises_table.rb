class RenameTweetsTableToNoisesTable < ActiveRecord::Migration
  def up
  	remove_index :tweets, :user_id
    rename_table :tweets, :noises
    add_index :noises, :user_id
  end

  def down
  	remove_index :noises, :user_id
    rename_table :noises, :tweets
    add_index :tweets, :user_id
  end
end
