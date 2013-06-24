class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :twitter_id
      t.references :user
      t.text :text
      t.decimal :coordinates_longitude
      t.decimal :coordinates_latitude

      t.timestamps
    end
    add_index :tweets, :user_id
  end
end
