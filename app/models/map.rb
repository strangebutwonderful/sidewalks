class Map
  attr_accessor :latlngs, :north_east_boundary_latlng, :south_west_boundary_latlng

  def initialize(latlngs, params = {})
    self.add_latlngs(latlngs)
    self.center = params[:center]
    self.zoom = params[:zoom]
  end

  def add_latlng(latlng)
    latlngs ||= []

    unless latlng.blank?
      raise TypeError.new("Attempted to add a non LatLng object to map:" + latlng.inspect) unless latlng.is_a? LatLng

      latlngs << latlng

      if self.north_east_boundary_latlng.present?
        self.north_east_boundary_latlng.expand_north_east(latlng)
      else
        self.north_east_boundary_latlng = latlng
      end

      if self.south_west_boundary_latlng.present?
        self.south_west_boundary_latlng.expand_south_west(latlng)
      else
        self.south_west_boundary_latlng = latlng
      end
    end

    latlngs
  end

  def add_latlngs(latlngs)
    if latlngs.is_a? Enumerable
      latlngs.each do |latlng|
        self.add_latlng(latlng)
      end
    else
      self.add_latlng(latlngs)
    end

    self.latlngs
  end

  def boundaries
    [
      south_west_boundary,
      north_east_boundary
    ]
  end

  def south_west_boundary
    [
      self.south_west_boundary_latlng.latitude, 
      self.south_west_boundary_latlng.longitude
    ]
  end

  def north_east_boundary
    [
      self.north_east_boundary_latlng.latitude, 
      self.north_east_boundary_latlng.longitude
    ]
  end

  def centered_latitude
    @centered_latitude = (self.south_west_boundary_latlng.latitude + self.north_east_boundary_latlng.latitude) / 2 unless @centered_latitude
  end

  def centered_longitude    
    @centered_longitude = (self.south_west_boundary_latlng.longitude + self.north_east_boundary_latlng.longitude) / 2 unless @centered_longitude
  end

  def center=(value)
    @center = value
  end

  def center 
    @center ||= [centered_latitude, centered_longitude]
  end

  def zoom=(value)
    @zoom = value
  end

  def zoom 
    @zoom ||= 16
  end

end