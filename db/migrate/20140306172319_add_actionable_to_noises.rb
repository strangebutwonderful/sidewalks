class AddActionableToNoises < ActiveRecord::Migration
  def change
    add_column :noises, :actionable, :boolean
  end
end
