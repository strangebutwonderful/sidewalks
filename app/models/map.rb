class Map
  attr_accessor :coordinates
  attr_reader :north_east_boundary_latitude, :north_east_boundary_longitude, :south_west_boundary_latitude, :south_west_boundary_longitude

  def initialize(coordinates = nil)
    self.coordinates = coordinates
  end

  def boundaries
    unless @boundaries
      coordinates.each do |coordinate|
        self.stretch_north_east_boundary_latitude(coordinate[0])
        self.stretch_north_east_boundary_longitude(coordinate[1])
        self.stretch_south_west_boundary_latitude(coordinate[0])
        self.stretch_south_west_boundary_longitude(coordinate[1])
      end

      @boundaries = [
        [self.south_west_boundary_latitude, self.south_west_boundary_longitude],
        [self.north_east_boundary_latitude, self.north_east_boundary_longitude]
      ]
    end

    @boundaries
  end

  def stretch_north_east_boundary_latitude(latitude)
    if @north_east_boundary_latitude.nil?
      @north_east_boundary_latitude = latitude
    end
    @north_east_boundary_latitude = [@north_east_boundary_latitude, latitude].max
  end 

  def stretch_north_east_boundary_longitude(longitude)
    if @north_east_boundary_longitude.nil?
      @north_east_boundary_longitude = longitude
    end
    @north_east_boundary_longitude = [@north_east_boundary_longitude, longitude].max
  end 

  def stretch_south_west_boundary_latitude(latitude)
    if @south_west_boundary_latitude.nil?
      @south_west_boundary_latitude = latitude
    end
    @south_west_boundary_latitude = [@south_west_boundary_latitude, latitude].min
  end 

  def stretch_south_west_boundary_longitude(longitude)
    if @south_west_boundary_longitude.nil?
      @south_west_boundary_longitude = longitude
    end
    @south_west_boundary_longitude = [@south_west_boundary_longitude, longitude].min
  end 

end