class LatLngGroup
  attr_accessor :latlngs

  delegate :count, to: :latlngs

  def initialize(latlngs)
    self.latlngs = []
    add_latlngs latlngs
  end

  def add_latlng(value)
    self.latlngs << value unless value.nil?

    self
  end

  def add_latlngs(value)
    value = [value] unless value.is_a? Enumerable

    value.each do |value|
      add_latlng(value)
    end

    self
  end

  def center
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

  def north_eastern
    raise "Cannot determine north eastern for an empty list of LatLngs" if latlngs.empty?

    lat = latlngs.map(&:latitude).max
    long = latlngs.map(&:longitude).max
    LatLng.new(lat, long)
  end

  def south_western
    raise "Cannot determine south_western for an empty list of LatLngs" if latlngs.empty?

    lat = latlngs.map(&:latitude).min
    long = latlngs.map(&:longitude).min
    LatLng.new(lat, long)
  end

  def bounding_box
    [
      south_western.to_a,
      north_eastern.to_a,
    ]
  end
end
