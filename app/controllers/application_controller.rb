class ApplicationController < ActionController::Base
  include Authentication
  include Geography

  protect_from_forgery

  helper_method :current_user_last_trail
  helper_method :google_universal_analytics_tracking_code
  helper_method :import_noises
  private

  def save_current_user_last_trail
    begin 
      Trail.update_recent(current_user, request_latitude, request_longitude) if current_user 
    rescue Exception => exception
      Rails.logger.error exception
      nil
    end
  end

  def current_user_last_trail
    if current_user
      @current_user_last_trail ||= current_user.trails.last
    end
  end

  def import_noises
    TwitterNoiseImporter.import_latest_from_sidewalks_twitter
  end

  def google_universal_analytics_tracking_code
    if Rails.env.production?
      ENV['GOOGLE_UNIVERSAL_ANALYTICS_TRACKING_CODE']
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

end
