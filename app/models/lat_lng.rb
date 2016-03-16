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

  def ==(another_latlng)
    (latitude == another_latlng.latitude) && (longitude == another_latlng.longitude)
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

  def self.north_eastern(latlngs)
    raise "Cannot center an empty list of LatLngs" if latlngs.empty?

    lat = latlngs.map( &:latitude ).max
    long = latlngs.map( &:longitude ).max
    LatLng.new(lat, long)
  end

  def self.south_western(latlngs)
    raise "Cannot center an empty list of LatLngs" if latlngs.empty?

    lat = latlngs.map( &:latitude ).min
    long = latlngs.map( &:longitude ).min
    LatLng.new(lat, long)
  end

  def self.bounding_box(latlngs)
    [
      south_western(latlngs).to_a,
      north_eastern(latlngs).to_a,
    ]
  end

  private

  def value_to_coordinate(value)
    raise "Setting a blank coordinate is not allowed" if value.blank?
    BigDecimal.new(value)
  end
end
