module Authentication
  extend ActiveSupport::Concern
  included do
    helper_method(
      :correct_user?,
      :current_user,
      :current_user_is_admin?,
      :current_user_signed_in?,
      :sign_in,
      :sign_out,
      :verify_admin_or_redirect_to_root!
    )
  end

  def sign_in(user)
    # Reset the session after successful login, per
    # 2.8 Session Fixation – Countermeasures:
    # http://guides.rubyonrails.org/security.html#session-fixation-countermeasures
    reset_session
    session[:user_id] = user.id
  end

  def sign_out
    reset_session
  end

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue => exception
      Rails.logger.error exception
      nil
    end
  end

  def current_user_is_admin?
    @current_user_is_admin ||= (
      current_user_signed_in? && current_user.has_role?(:admin)
    )
  end

  def current_user_signed_in?
    return true if current_user
  end

  def authenticate_user_or_redirect_to_root!
    if !current_user
      redirect_to(
        root_url,
        alert: "You need to sign in for access to this page."
      )
    end
  end

  def verify_admin_or_redirect_to_root!
    redirect_to root_url unless current_user.has_role? :admin
  end
end
