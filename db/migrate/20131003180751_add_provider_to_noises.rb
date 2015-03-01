class AddProviderToNoises < ActiveRecord::Migration
  def change
    add_column :noises, :provider, :string

    Noise.update_all(provider: Noise::PROVIDER_TWITTER)
  end
end
