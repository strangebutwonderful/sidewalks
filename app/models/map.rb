class Map
  attr_accessor :coordinates
  attr_reader :north_east_boundary_latitude, :north_east_boundary_longitude, :south_west_boundary_latitude, :south_west_boundary_longitude

  def initialize(coordinates = nil)
    self.add_coordinates(coordinates)
  end

  def add_coordinates(coordinates)
    self.coordinates ||= []
    unless coordinates.blank?
      @boundaries = nil
      self.coordinates += coordinates
    end

    self.coordinates
  end

  def boundaries
    unless @boundaries
      self.coordinates.each do |coordinate|
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

  def centered_latitude
    unless @centered_latitude
      @centered_latitude = (self.boundaries[0][0] + self.boundaries[1][0]) / 2
    end

    @centered_latitude
  end

  def centered_longitude
    unless @centered_longitude
      @centered_longitude = (self.boundaries[0][1] + self.boundaries[1][1]) / 2
    end

    @centered_longitude
  end

  def center 
    [centered_latitude, centered_longitude]
  end

  def stretch_north_east_boundary_latitude(latitude)
    latitude = BigDecimal.new(latitude) unless latitude.is_a? BigDecimal
    if @north_east_boundary_latitude.nil?
      @north_east_boundary_latitude = latitude
    end
    @north_east_boundary_latitude = [@north_east_boundary_latitude, latitude].max
  end 

  def stretch_north_east_boundary_longitude(longitude)
    longitude = BigDecimal.new(longitude) unless longitude.is_a? BigDecimal
    if @north_east_boundary_longitude.nil?
      @north_east_boundary_longitude = longitude
    end
    @north_east_boundary_longitude = [@north_east_boundary_longitude, longitude].max
  end 

  def stretch_south_west_boundary_latitude(latitude)
    latitude = BigDecimal.new(latitude) unless latitude.is_a? BigDecimal
    if @south_west_boundary_latitude.nil?
      @south_west_boundary_latitude = latitude
    end
    @south_west_boundary_latitude = [@south_west_boundary_latitude, latitude].min
  end 

  def stretch_south_west_boundary_longitude(longitude)
    longitude = BigDecimal.new(longitude) unless longitude.is_a? BigDecimal
    if @south_west_boundary_longitude.nil?
      @south_west_boundary_longitude = longitude
    end
    @south_west_boundary_longitude = [@south_west_boundary_longitude, longitude].min
  end 

end