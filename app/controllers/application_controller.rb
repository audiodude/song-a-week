class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_login
    login_from_session
    if !@current_user
      flash[:notice] = {
        cls: 'warning',
        msg: 'Login is required to view that page.'
      }
      redirect_to :login
    end
  end

  def set_login_session(user)
    session[:user_id] = user.id
  end

  def remove_login_session
    session.delete(:user_id)
  end
end
