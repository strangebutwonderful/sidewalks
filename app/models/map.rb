class Map
  attr_accessor :latlngs

  def initialize(initial_latlngs = nil, params = {})
    self.latlngs ||= []
    self.add_latlngs(initial_latlngs)
    self.center = params[:center] if params[:center].present?
    self.zoom = params[:zoom] if params[:zoom].present?
  end

  def add_latlng(value)
    unless value.nil?
      self.latlngs << value
    end

    self
  end

  def add_latlngs(value)
    value = [value] unless value.is_a? Enumerable

    value.each do |value|
      self.add_latlng(value)
    end

    self
  end

  def boundaries
    [
      self.south_west_boundary,
      self.north_east_boundary
    ]
  end

  def default_latlng
    Neighborhood.districts(:civic_center)
  end

  def north_east_boundary_latlng
    @north_east_boundary_latlng ||= calculate_north_east
  end

  def south_west_boundary_latlng
    @south_west_boundary_latlng ||= calculate_south_west
  end

  def north_east_boundary
    self.north_east_boundary_latlng.to_a
  end

  def south_west_boundary
    self.south_west_boundary_latlng.to_a
  end

  def center=(value)
    @center = value
  end

  def center
    @center ||= LatLng.center(latlngs).to_a
  end

  def zoom=(value)
    @zoom = value
  end

  def zoom
    @zoom ||= 16
  end

  private

  def calculate_north_east
    boundary_latlng = self.latlngs.first
    self.latlngs.each do |latlng|
      boundary_latlng.expand_north_east(latlng)
    end
    boundary_latlng
  end

  def calculate_south_west
    boundary_latlng = self.latlngs.first
    self.latlngs.each do |latlng|
      boundary_latlng.expand_south_west(latlng)
    end
    boundary_latlng
  end

end
