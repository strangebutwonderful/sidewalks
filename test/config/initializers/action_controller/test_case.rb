class ActionController::TestCase
  # include Authentication

  # Mimics Authentication#sign_in
  def sign_in(user)
    request.reset_session
    session[:user_id] = user.id
  end

  # Mimics Authentication#sign_out
  def sign_out
    request.reset_session
  end
end
