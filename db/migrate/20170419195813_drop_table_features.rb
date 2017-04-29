class DropTableFeatures < ActiveRecord::Migration
  def change
    drop_table :features
  end
end
