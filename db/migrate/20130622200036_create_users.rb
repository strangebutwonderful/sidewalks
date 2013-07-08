class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :provider
      t.string :provider_id
      t.string :provider_screen_name
      t.string :provider_access_token
      t.string :provider_access_token_secret

      t.timestamps
    end
  end
end
