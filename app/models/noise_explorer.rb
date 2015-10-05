class NoiseExplorer < ActiveRecord::Base
  def self.explore_and_group(latitude, longitude, distance, created_at)
    Noise.
      explore_nearest(latitude, longitude, distance, created_at).
      group_by &:user_id
  end
end
