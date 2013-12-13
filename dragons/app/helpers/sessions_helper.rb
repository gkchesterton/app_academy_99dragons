module SessionsHelper
  def login!(user)
    environment = request.env["HTTP_USER_AGENT"]
    user.reset_session_token(environment)
    user.save
    session[:session_token] =
            UserSession.find_by_user_id_and_environment(user.id,
                        environment).session_token
  end

  def current_user
    unless session[:session_token].nil?
      user_session = UserSession.find_by_session_token(session[:session_token])
      user_session.user
    end
  end

  def logout!(sess = UserSession.find_by_session_token(session[:session_token]))
    if sess.session_token == session[:session_token]
      session[:session_token] = nil
    end
    session.destroy
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
