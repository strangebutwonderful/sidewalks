class NoiseExplorer < ActiveRecord::Base
  def self.explore_and_group(params)
    Noise.explore_nearest(params).group_by &:user_id
  end
end
