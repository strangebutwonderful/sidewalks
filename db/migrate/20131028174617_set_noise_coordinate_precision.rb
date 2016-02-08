class SetNoiseCoordinatePrecision < ActiveRecord::Migration
  def up
    change_column :noises, :coordinates_latitude, :decimal, precision: 11, scale: 8
    change_column :noises, :coordinates_longitude, :decimal, precision: 11, scale: 8

    rename_column :noises, :coordinates_latitude, :latitude
    rename_column :noises, :coordinates_longitude, :longitude

    add_index 'noises', %w(latitude longitude), name: 'index_noises_on_latitude_and_longitude'
  end

  def down
  end
end
