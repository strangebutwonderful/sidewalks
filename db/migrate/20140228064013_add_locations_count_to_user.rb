class AddLocationsCountToUser < ActiveRecord::Migration
  def up
    add_column :users, :locations_count, :integer, default: 0, null: false
  end
end
