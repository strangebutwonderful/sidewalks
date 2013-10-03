class NoiseTwitterIdToProviderId < ActiveRecord::Migration
  def up
    rename_column :noises, :twitter_id, :provider_id
  end

  def down
    rename_column :noises, :provider_id, :twitter_id
  end
end
