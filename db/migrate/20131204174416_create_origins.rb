class CreateOrigins < ActiveRecord::Migration
  def change
    create_table :origins do |t|
      t.belongs_to :noise, :null => false

      t.decimal :latitude, :precision => 11, :scale => 8
      t.decimal :longitude, :precision => 11, :scale => 8

      t.timestamps
    end
  end
end
