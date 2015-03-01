class LatLng

  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    self.latitude = latitude
    self.longitude = longitude
  end

  def coordinates
    [
      self.latitude,
      self.longitude
    ]
  end

  def expand_north_east(latlng)
    self.latitude = latlng.latitude if latlng.latitude > self.latitude
    self.longitude = latlng.longitude if latlng.longitude > self.longitude

    self
  end

  def expand_south_west(latlng)
    self.latitude = latlng.latitude if latlng.latitude < self.latitude
    self.longitude = latlng.longitude if latlng.longitude < self.longitude

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
      self.latitude,
      self.longitude
    ]
  end

  def ==(another_latlng)
    self.latitude == another_latlng.latitude && self.longitude == another_latlng.longitude
  end

  def self.center(latlngs)
    raise "Cannot center an empty list of LatLngs" if latlngs.empty?

    summed_latitude = BigDecimal.new(0)
    summed_longitude = BigDecimal.new(0)

    latlngs.each do |latlng|
      summed_latitude += latlng.latitude
      summed_longitude += latlng.longitude
    end

    latlngs_count = latlngs.count

    LatLng.new(
      summed_latitude / BigDecimal.new(latlngs_count),
      summed_longitude / BigDecimal.new(latlngs_count)
    )
  end

  private

  def value_to_coordinate(value)
    raise "Setting a blank coordinate is not allowed" if value.blank?
    BigDecimal.new(value)
  end

end