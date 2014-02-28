module Cartography

  def request_latitude
    @request_latitude ||= params[:latitude]

    if @request_latitude.blank? && request.location.present?
      @request_latitude ||= request.location.latitude.to_s
    end

    if @request_latitude.blank?
      @request_latitude = Neighborhood::city(:sanfrancisco).latitude
    end    

    @request_latitude
  end

  def request_longitude
    @request_longitude ||= params[:longitude]
    
    if @request_longitude.blank? && request.location.present?
      @request_longitude ||= request.location.longitude.to_s
    end

    if @request_longitude.blank?
      @request_longitude = Neighborhood::city(:sanfrancisco).longitude
    end

    @request_longitude
  end

  def request_latlng
    LatLng.new(request_latitude, request_longitude)
  end

  def request_geolocation
    params[:latitude] = request_latitude
    params[:longitude] = request_longitude
  end

  def self.included method 
    return unless method < ActionController::Base
    method.helper_method :request_latitude, :request_longitude, :request_latlng, :request_geolocation # , :any_other_helper_methods

  end

end