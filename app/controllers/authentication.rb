module Authentication

  def sign_in(user) 
    # Reset the session after successful login, per
    # 2.8 Session Fixation – Countermeasures:
    # http://guides.rubyonrails.org/security.html#session-fixation-countermeasures
    request.reset_session
    session[:user_id] = user.id
  end

  def sign_out
    request.reset_session
  end

  def authenticate_user!
    if !current_user
      redirect_to root_url, :alert => 'You need to sign in for access to this page.'
    end
  end

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue Exception => exception
      Rails.logger.error exception
      nil
    end
  end

  def current_user_is_admin?
    @current_user_is_admin ||= current_user_signed_in? && current_user.has_role?(:admin)
  end

  def current_user_signed_in?
    return true if current_user
  end

  def verify_admin
    redirect_to root_url unless current_user.has_role? :admin
  end

  def self.included method 
    return unless method < ActionController::Base
    method.helper_method :correct_user?, :current_user, :current_user, :current_user_is_admin?, :current_user_signed_in?, :sign_in # , :any_other_helper_methods

  end

end