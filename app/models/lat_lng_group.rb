class LatLngGroup
  attr_accessor :lat_lngs

  delegate :count, to: :lat_lngs

  def initialize(lat_lngs)
    self.lat_lngs = []
    add_lat_lngs lat_lngs
  end

  def add_lat_lng(value)
    self.lat_lngs << value unless value.nil?

    self
  end

  def add_lat_lngs(value)
    value = [value] unless value.is_a? Enumerable

    value.each do |value|
      add_lat_lng(value)
    end

    self
  end

  def center
    raise "Cannot center an empty list of LatLngs" if lat_lngs.empty?

    summed_latitude = BigDecimal.new(0)
    summed_longitude = BigDecimal.new(0)

    lat_lngs.each do |lat_lng|
      summed_latitude += lat_lng.latitude
      summed_longitude += lat_lng.longitude
    end

    lat_lngs_count = lat_lngs.count

    LatLng.new(
      summed_latitude / BigDecimal.new(lat_lngs_count),
      summed_longitude / BigDecimal.new(lat_lngs_count)
    )
  end

  def north_eastern
    raise "Cannot determine north eastern for an empty list of LatLngs" if lat_lngs.empty?

    lat = lat_lngs.map(&:latitude).max
    long = lat_lngs.map(&:longitude).max
    LatLng.new(lat, long)
  end

  def south_western
    raise "Cannot determine south_western for an empty list of LatLngs" if lat_lngs.empty?

    lat = lat_lngs.map(&:latitude).min
    long = lat_lngs.map(&:longitude).min
    LatLng.new(lat, long)
  end

  def bounding_box
    [
      south_western.to_a,
      north_eastern.to_a,
    ]
  end
end
