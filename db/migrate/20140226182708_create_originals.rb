class CreateOriginals < ActiveRecord::Migration
  def change
    create_table :originals do |t|
      t.references :importable, :polymorphic => true, :null => false, :index => true
      t.column :dump, :json, :null => false

      t.timestamps
    end
  end
end
