module ApplicationHelper
  def signed_in?
    login_from_session
    @current_user != nil
  end

  def login_from_session
    if !@current_user && session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end
end
