### 
# Tracking is the backend support for the user's last know position
###
module Tracking
  
  def last_known_latlng
    # 1. params[:ll] // side effect save trail
    # 2. user.last_know_trail || session[:ll]
    if current_user
      if current_user.trails.first
        @current_user_last_latlng ||= current_user.trails.first.latlng 
      else 
        @current_user_last_latlng ||= LatLng.new(request_latitude, request_longitude)
      end
    end

    @current_user_last_latlng
  end

  def update_last_known_latlng
    # cookies[:latlng] comes in the form "latitude,longitude"
    unless cookies[:latlng].blank?
      Rails.logger.debug "latlng cookie: #{cookies[:latlng]}"
      coordinates = cookies[:latlng]
      Trail.update_recent(current_user, coordinates[0], coordinates[1]) if current_user 
    end
  end

  def self.included method 
    return unless method < ActionController::Base
    method.helper_method :last_known_latlng, :update_last_known_latlng    
  end

end