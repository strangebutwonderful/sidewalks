class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.belongs_to :user, :null => false
      t.decimal :latitude, :precision => 11, :scale => 8
      t.decimal :longitude, :precision => 11, :scale => 8

      t.timestamps
    end
    
    add_index :trails, :user_id
    add_index :trails, :latitude
    add_index :trails, :longitude
  end
end
