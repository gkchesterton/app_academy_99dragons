module SessionsHelper
  def login!(user)
    user.reset_session_token
    user.save
    session[:session_token] = user.session_token
  end

  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def logout!
    current_user.reset_session_token
    session[:session_token] = nil
  end

  def require_current_user
    redirect_to new_session_url if current_user.nil?
  end

  def redirect_unless_owner
    redirect_to user_url(current_user) unless current_user_is_owner?
  end

  def current_user_is_owner?(dragon_id = params[:id])
    Dragon.find(dragon_id).user_id == current_user.id
  end
end
