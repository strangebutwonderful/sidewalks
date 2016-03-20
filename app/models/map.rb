class Map
  attr_accessor :lat_lng_group
  attr_writer :center, :zoom

  delegate :add_lat_lng, :add_lat_lngs, :bounding_box, :center, to: :lat_lng_group

  def initialize(initial_lat_lng_group = nil, params = {})
    self.lat_lng_group = LatLngGroup.new(initial_lat_lng_group)
    self.center = params[:center] if params[:center].present?
    self.zoom = params[:zoom] if params[:zoom].present?
  end

  def bounding_box
    lat_lng_group.bounding_box
  end

  def default_lat_lng
    Neighborhood.districts(:civic_center)
  end

  def center
    @center ||= lat_lng_group.center.to_a
  end

  def zoom
    @zoom ||= 16
  end
end
