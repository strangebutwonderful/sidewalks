class SessionsController < ApplicationController
  def new
    redirect_to "/auth/twitter"
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.where(
      provider: auth["provider"],
      provider_id: auth["uid"].to_s
    ).first || User.create_from_omniauth!(auth)
    user.update_credentials(auth)
    sign_in user
    if user.email.blank?
      redirect_to edit_user_path(user), alert: "Please enter your email address."
    else
      redirect_to root_url, notice: "Signed in!"
    end
  end

  def destroy
    sign_out
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    params[:message] ||= ""
    redirect_to root_url, alert: "Authentication error: #{params[:message].humanize}"
  end
end
