class AddAvatarImageUrlToNoises < ActiveRecord::Migration
  def change
    add_column :noises, :avatar_image_url, :string, :null => true
  end
end
