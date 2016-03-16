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

  def bounding_box
    LatLng.bounding_box(latlngs)
  end

  def default_latlng
    Neighborhood.districts(:civic_center)
  end

  attr_writer :center

  def center
    @center ||= LatLng.center(latlngs).to_a
  end

  attr_writer :zoom

  def zoom
    @zoom ||= 16
  end
end
