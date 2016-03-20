###
# Tracking is the backend support for the user's last know position
###
module Tracking
  extend ActiveSupport::Concern
  included do
    helper_method :last_known_lat_lng
    helper_method :update_last_known_lat_lng
  end

  def last_known_lat_lng
    @last_known_lat_lng ||= lat_lng_from_cookie || lat_lng_from_request
  end

  private

  def lat_lng_from_cookie
    return nil unless cookies[:lat_lng].present?

    @lat_lng_from_cookie ||= begin
      # cookies[:lat_lng] comes in the form "latitude,longitude"
      coordinates = cookies[:lat_lng].split(",")
      LatLng.new(coordinates[0], coordinates[1])
    end
  end

  def lat_lng_from_cookie?
    lat_lng_from_cookie.present?
  end

  def lat_lng_from_request
    @lat_lng_from_request ||= LatLng.new(
      request_latitude,
      request_longitude
    )
  end
end
