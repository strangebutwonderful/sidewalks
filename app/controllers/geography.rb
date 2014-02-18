module Geography

  def request_latitude
    @request_latitude ||= params[:latitude]

    if Rails.env.development?
      @request_latitude ||= "37.7833" # san francisco
    elsif @request_latitude.blank? && request.location.present?
      @request_latitude ||= request.location.latitude.to_s
    end

    @request_latitude
  end

  def request_longitude
    @request_longitude ||= params[:longitude]
    
    if Rails.env.development?
      @request_longitude ||= "-122.4167" # san francisco
    elsif @request_longitude.blank? && request.location.present?
      @request_longitude ||= request.location.longitude.to_s
    end

    @request_longitude
  end

  def request_coordinates
    [request_latitude, request_longitude]
  end

  def request_geolocation
    params[:latitude] = request_latitude
    params[:longitude] = request_longitude
  end

  def self.included method 
    return unless method < ActionController::Base
    method.helper_method :request_latitude, :request_longitude, :request_coordinates, :request_geolocation # , :any_other_helper_methods

  end

end