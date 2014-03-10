### 
# Tracking is the backend support for the user's last know position
###
module Tracking
  
  def last_known_latlng
    @current_user_last_latlng ||= update_last_known_latlng
  end

  def update_last_known_latlng
    Rails.logger.debug "latlng cookie: #{cookies[:latlng]}"

    # cookies[:latlng] comes in the form "latitude,longitude"
    unless cookies[:latlng].blank?
      coordinates = cookies[:latlng].split(',')
      @current_user_last_latlng ||= LatLng.new(coordinates[0], coordinates[1])

      # Side effect behavior of saving the latlng for later
      Trail.update_recent(current_user, coordinates[0], coordinates[1]) if current_user_signed_in?
    else
      @current_user_last_latlng ||= LatLng.new(request_latitude, request_longitude)
    end

    @current_user_last_latlng
  end

  def self.included method 
    return unless method < ActionController::Base
    method.helper_method :last_known_latlng, :update_last_known_latlng    
  end

end