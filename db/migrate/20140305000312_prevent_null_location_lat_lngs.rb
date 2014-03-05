class PreventNullLocationLatLngs < ActiveRecord::Migration
  def up
    change_column_null(:locations, :latitude, false)
    change_column_null(:locations, :longitude, false)
  end

  def down
    change_column_null(:locations, :latitude, true)
    change_column_null(:locations, :longitude, true)
  end
end
