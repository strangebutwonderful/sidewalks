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
    @last_known_lat_lng ||= lat_lng_from_request
  end

  private

  def lat_lng_from_request
    @lat_lng_from_request ||= LatLng.new(
      request_latitude,
      request_longitude
    )
  end
end
