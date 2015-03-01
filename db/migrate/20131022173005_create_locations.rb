class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.belongs_to :user, :null => false

      t.string :address, :null => false
      t.string :city, :null => false
      t.string :state, :null => false
      t.integer :zip, :null => false
      t.decimal :latitude, :precision => 11, :scale => 8
      t.decimal :longitude, :precision => 11, :scale => 8

      t.timestamps
    end

    add_index :locations, :user_id
    add_index :locations, [:user_id, :address, :city, :state, :zip], :unique => true, :name => 'unique_user_and_locations'
    add_index :locations, [:latitude, :longitude]
  end
end
