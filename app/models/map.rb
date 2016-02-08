class Map
  attr_accessor :latlngs

  def initialize(initial_latlngs = nil, params = {})
    self.latlngs ||= []
    add_latlngs(initial_latlngs)
    self.center = params[:center] if params[:center].present?
    self.zoom = params[:zoom] if params[:zoom].present?
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

  def boundaries
    [
      south_west_boundary,
      north_east_boundary
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
    north_east_boundary_latlng.to_a
  end

  def south_west_boundary
    south_west_boundary_latlng.to_a
  end

  attr_writer :center

  def center
    @center ||= LatLng.center(latlngs).to_a
  end

  attr_writer :zoom

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
