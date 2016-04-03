###
# RequestCartography is the backend support for the user's last know position
###
module RequestCartography
  extend ActiveSupport::Concern
  included do
    helper_method :request_lat_lng
  end

  def request_lat_lng
    @request_lat_lng ||= LatLng.new(
      request_latitude,
      request_longitude
    )
  end

  private

  def request_latitude
    @request_latitude ||= params[:latitude]

    if @request_latitude.blank?
      @request_latitude = Neighborhood.districts[:civic_center].latitude
    end

    @request_latitude
  end

  def request_longitude
    @request_longitude ||= params[:longitude]

    if @request_longitude.blank?
      @request_longitude = Neighborhood.districts[:civic_center].longitude
    end

    @request_longitude
  end
end
