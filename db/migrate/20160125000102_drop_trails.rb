class DropTrails < ActiveRecord::Migration
  def change
    drop_table :trails
  end
end
