class Map
  attr_accessor :latlng_group
  attr_writer :center, :zoom

  delegate :add_latlng, :add_latlngs, :bounding_box, :center, to: :latlng_group

  def initialize(initial_latlng_group = nil, params = {})
    self.latlng_group = LatLngGroup.new(initial_latlng_group)
    self.center = params[:center] if params[:center].present?
    self.zoom = params[:zoom] if params[:zoom].present?
  end

  def bounding_box
    latlng_group.bounding_box
  end

  def default_latlng
    Neighborhood.districts(:civic_center)
  end

  def center
    @center ||= latlng_group.center.to_a
  end

  def zoom
    @zoom ||= 16
  end
end
