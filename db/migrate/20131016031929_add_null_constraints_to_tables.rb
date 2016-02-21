class AddNullConstraintsToTables < ActiveRecord::Migration
  def change
    # change_column :table_name, :column_name, :column_type, :null => false
    change_column :noises, :provider, :string, null: false
    change_column :noises, :provider_id, :string, null: false
    change_column :noises, :text, :text, null: false
    change_column :noises, :user_id, :integer, null: false

    change_column :roles, :name, :string, null: false

    change_column :users, :name, :string, null: false
    change_column :users, :provider, :string, null: false
    change_column :users, :provider_id, :string, null: false

    change_column :users_roles, :user_id, :integer, null: false
    change_column :users_roles, :role_id, :integer, null: false
  end
end
