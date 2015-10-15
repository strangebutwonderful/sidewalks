module Profiling
  extend ActiveSupport::Concern
  included do
    helper_method(
      :rack_profile_if_admin
    )
  end

  def rack_profile_if_admin
    if current_user_is_admin?
      Rack::MiniProfiler.authorize_request
    end
  end
end
