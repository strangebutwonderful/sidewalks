class LatLng

  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    self.latitude = latitude
    self.longitude = longitude
  end

  def latitude=(value)
    @latitude = value_to_coordinate(value)
  end

  def longitude=(value)
    @longitude = value_to_coordinate(value)
  end

  private 

  def value_to_coordinate(value)
    
    raise "Setting a blank coordinate is not allowed" if value.blank?

    BigDecimal.new(value)
  end

end