class ApplicationController < ActionController::Base
  include Authentication

  protect_from_forgery

  helper_method :current_user_last_trail
  helper_method :google_universal_analytics_tracking_code
  helper_method :import_noises

  private

  def request_latitude
    @request_latitude ||= params[:latitude]

    if Rails.env.development?
      @request_latitude ||= 122.4167 # san francisco
    elsif @request_latitude.blank? && request.location.present?
      @request_latitude ||= request.location.latitude
    end

    @request_latitude
  end

  def request_longitude
    @request_longitude ||= params[:longitude]
    
    if Rails.env.development?
      @request_longitude ||= 37.7833 # san francisco
    elsif @request_longitude.blank? && request.location.present?
      @request_longitude ||= request.location.longitude
    end

    @request_longitude
  end

  def save_current_user_last_trail
    begin 
      Trail.update_recent(current_user, request_latitude, request_longitude) if current_user 
    rescue Exception => exception
      Rails.logger.error exception
      nil
    end
  end

  def current_user_last_trail
    @current_user_last_trail ||= current_user.trails.last
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
