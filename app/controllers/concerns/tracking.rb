###
# Tracking is the backend support for the user's last know position
###
module Tracking
  extend ActiveSupport::Concern
  included do
    helper_method :last_known_latlng
    helper_method :update_last_known_latlng
  end

  def last_known_latlng
    @last_known_latlng ||= latlng_from_cookie || latlng_from_request
  end

  private

  def latlng_from_cookie
    return nil unless cookies[:latlng].present?

    @latlng_from_cookie ||= begin
      # cookies[:latlng] comes in the form "latitude,longitude"
      coordinates = cookies[:latlng].split(',')
      LatLng.new(coordinates[0], coordinates[1])
    end
  end

  def latlng_from_cookie?
    latlng_from_cookie.present?
  end

  def latlng_from_request
    @latlng_from_request ||= LatLng.new(
      request_latitude,
      request_longitude
    )
  end
end
