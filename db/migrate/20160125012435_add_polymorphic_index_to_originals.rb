class AddPolymorphicIndexToOriginals < ActiveRecord::Migration
  def change
    add_index :originals, [:importable_id, :importable_type]
  end
end
