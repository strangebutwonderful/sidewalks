class NoiseFunnel
  attr_reader(
    :latitude,
    :longitude,
    :minimum_distance,
    :maximum_distance,
    :minimum_created_at,
    :maximum_created_at
  )

  def initialize(
    latitude,
    longitude,
    minimum_distance,
    maximum_distance,
    minimum_created_at,
    maximum_created_at
  )
    @latitude = latitude
    @longitude = longitude
    @minimum_distance = minimum_distance
    @maximum_distance = maximum_distance
    @minimum_created_at = minimum_created_at
    @maximum_created_at = maximum_created_at
  end

  def noises
    @noises ||= (bottom_of_funnel.all + top_of_funnel.all)
  end

  def noise_grouped_by_user_id
    @noise_grouped_by_user_id ||= noises.group_by &:user_id
  end

  private

  def top_of_funnel
    Noise.explore_nearest(
      latitude, longitude, maximum_distance, minimum_created_at
    )
  end

  def bottom_of_funnel
    Noise.explore_nearest(
      latitude, longitude, minimum_distance, maximum_created_at
    )
  end
end
