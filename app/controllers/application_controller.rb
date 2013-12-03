class ApplicationController < ActionController::Base
  include Authentication

  protect_from_forgery

  helper_method :google_universal_analytics_tracking_code
  helper_method :import_noises

  private

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
