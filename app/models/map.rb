class Map
  attr_accessor :coordinates, :north_east_boundary_latitude, :north_east_boundary_longitude, :south_west_boundary_latitude, :south_west_boundary_longitude

  def initialize(coordinates = nil, params = {})
    self.add_coordinates(coordinates)
    self.center = params[:center]
    self.zoom = params[:zoom]
  end

  def add_coordinates(coordinates)
    self.coordinates ||= []
    
    unless coordinates.blank?
      @boundaries = nil
      self.coordinates += coordinates

      self.coordinates.each do |coordinate|
        self.south_west_boundary_latitude  = evaluate_boundary(self.south_west_boundary_latitude,  coordinate[0]).min
        self.south_west_boundary_longitude = evaluate_boundary(self.south_west_boundary_longitude, coordinate[1]).min
        self.north_east_boundary_latitude  = evaluate_boundary(self.north_east_boundary_latitude,  coordinate[0]).max
        self.north_east_boundary_longitude = evaluate_boundary(self.north_east_boundary_longitude, coordinate[1]).max
      end      
    end

    self.coordinates
  end

  def boundaries
    [
      south_west_boundary,
      north_east_boundary
    ]
  end

  def south_west_boundary
    [self.south_west_boundary_latitude, self.south_west_boundary_longitude]
  end

  def north_east_boundary
    [self.north_east_boundary_latitude, self.north_east_boundary_longitude]
  end

  def centered_latitude
    @centered_latitude = (self.south_west_boundary_latitude + self.north_east_boundary_latitude) / 2 unless @centered_latitude
  end

  def centered_longitude    
    @centered_longitude = (self.south_west_boundary_longitude + self.north_east_boundary_longitude) / 2 unless @centered_longitude
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

  private 

  def evaluate_boundary(boundary_coordinate, coordinate)
    coordinate = BigDecimal.new(coordinate) unless coordinate.is_a? BigDecimal
    if boundary_coordinate.nil?
      boundary_coordinate = coordinate
    end
    [boundary_coordinate, coordinate]
  end

end