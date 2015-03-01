class AddUniqueIndexToOrigins < ActiveRecord::Migration
  def change
    add_index "origins", ["noise_id", "latitude", "longitude"], name: "index_origin_on_latitude_and_longitude", unique: true
  end
end
