class LatLng

  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    self.latitude = latitude
    self.longitude = longitude
  end

  def coordinates
    [
      @latitude, 
      @longitude
    ]
  end

  def expand_north_east(latlng)
    latlng.latitude = latitude if latlng.latitude > latitude
    latlng.longitude = longitude if latlng.longitude > longitude

    self
  end

  def expand_south_west(latlng)
    latlng.latitude = latitude if latlng.latitude < latitude
    latlng.longitude = longitude if latlng.longitude < longitude

    self
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

  private 

  def value_to_coordinate(value)
    raise "Setting a blank coordinate is not allowed" if value.blank?
    BigDecimal.new(value)
  end

end