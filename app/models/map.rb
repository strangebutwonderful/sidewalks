class Map
  attr_accessor :coordinates, :north_east_boundary_latitude, :north_east_boundary_longitude, :south_west_boundary_latitude, :south_west_boundary_longitude

  def initialize(coordinates = nil)
    self.add_coordinates(coordinates)
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
    @boundaries = [
      [self.south_west_boundary_latitude, self.south_west_boundary_longitude],
      [self.north_east_boundary_latitude, self.north_east_boundary_longitude]
    ] unless @boundaries
  end

  def centered_latitude
    @centered_latitude = (self.south_west_boundary_latitude + self.north_east_boundary_latitude) / 2 unless @centered_latitude
  end

  def centered_longitude    
    @centered_longitude = (self.south_west_boundary_longitude + self.north_east_boundary_longitude) / 2 unless @centered_longitude
  end

  def center 
    [centered_latitude, centered_longitude]
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