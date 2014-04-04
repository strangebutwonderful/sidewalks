class AddMobileVenuesCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mobile_venues_count, :integer
  end
end
