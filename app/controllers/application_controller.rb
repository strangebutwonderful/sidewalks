require "#{Rails.root}/lib/cartography/cartography"
require "#{Rails.root}/lib/layout/layout"
require "#{Rails.root}/lib/tracking/tracking"

class ApplicationController < ActionController::Base
  include Authentication
  include Cartography
  include Layout
  include Tracking

  protect_from_forgery

  before_filter :update_last_known_latlng

  helper_method :bugsnag_api_key
  helper_method :google_universal_analytics_tracking_code

  private

  def bugsnag_api_key
    if Rails.env.production?
      ENV['BUGSNAG_API_KEY']
    end
  end

  def google_universal_analytics_tracking_code
    if Rails.env.production?
      ENV['GOOGLE_UNIVERSAL_ANALYTICS_TRACKING_CODE']
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

end
