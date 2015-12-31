class AddIndexToTrailsCreatedAt < ActiveRecord::Migration
  def change
    add_index :trails, :created_at
  end
end
