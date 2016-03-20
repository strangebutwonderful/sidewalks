class LatLng
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    self.latitude = latitude
    self.longitude = longitude
  end

  def coordinates
    [
      latitude,
      longitude
    ]
  end

  def latitude=(value)
    @latitude = value_to_coordinate(value)
  end

  def longitude=(value)
    @longitude = value_to_coordinate(value)
  end

  def to_a
    [
      latitude,
      longitude
    ]
  end

  def ==(another_lat_lng)
    (latitude == another_lat_lng.latitude) && (longitude == another_lat_lng.longitude)
  end

  private

  def value_to_coordinate(value)
    raise "Setting a blank coordinate is not allowed" if value.blank?
    BigDecimal.new(value)
  end
end
