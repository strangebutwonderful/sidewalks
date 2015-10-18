module Cartography
  extend ActiveSupport::Concern
  included do
    helper_method(
      :request_latitude,
      :request_latlng,
      :request_longitude,
    )
  end

  def request_latitude
    @request_latitude ||= params[:latitude]

    if @request_latitude.blank? && request.location.present?
      @request_latitude ||= request.location.latitude.to_s
    end

    if @request_latitude.blank?
      @request_latitude = Neighborhood::districts[:civic_center].latitude
    end

    @request_latitude
  end

  def request_longitude
    @request_longitude ||= params[:longitude]

    if @request_longitude.blank? && request.location.present?
      @request_longitude ||= request.location.longitude.to_s
    end

    if @request_longitude.blank?
      @request_longitude = Neighborhood::districts[:civic_center].longitude
    end

    @request_longitude
  end

  def request_latlng
    LatLng.new(request_latitude, request_longitude)
  end

end
