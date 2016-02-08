class ApplicationController < ActionController::Base
  include Authentication
  include Cartography
  include Layout
  include Profiling
  include Tracking

  protect_from_forgery

  before_filter :rack_profile_if_admin

  helper_method :bugsnag_api_key
  helper_method :bugsnag_api_key?
  helper_method :google_universal_analytics_tracking_code
  helper_method :google_universal_analytics_tracking_code?

  private

  def bugsnag_api_key
    ENV['BUGSNAG_API_KEY']
  end

  def bugsnag_api_key?
    bugsnag_api_key.present?
  end

  def google_universal_analytics_tracking_code
    ENV['GOOGLE_UNIVERSAL_ANALYTICS_TRACKING_CODE']
  end

  def google_universal_analytics_tracking_code?
    google_universal_analytics_tracking_code.present?
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end
end
