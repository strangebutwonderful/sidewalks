class RemoveLatitudeAndLongitudeFromNoise < ActiveRecord::Migration
  def up
    remove_column :noises, :latitude
    remove_column :noises, :longitude
  end

  def down
    add_column :noises, :latitude, :decimal, :precision => 11, :scale => 8, :null => false
    add_column :noises, :longitude, :decimal, :precision => 11, :scale => 8, :null => false
  end
end
