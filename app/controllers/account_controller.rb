class AccountController < ApplicationController

def login
  @errors = {}
  if request.post?
    if params[:email].blank?
      @errors[:email] = 'Email is required.'
    end
    if params[:password].blank?
      @errors[:password] = 'Password is required.'
    end
    return unless @errors.empty?
      
    @user = User.find_by_email(params[:email])
    if @user.try(:authenticate, params[:password])
      if @user.status == 'NEW'
        flash.now[:notice] = {
          cls: 'warning',
          msg: 'You have successfully logged in but your account has not yet been approved. Please continue to monitor your email for more information.'
        }
      else
        set_login_session(@user)
        flash[:notice] = {
          cls: 'info',
          msg: 'You have been successfully logged in.'
        }
        redirect_to :root
      end
    else
      @errors[:general] = 'No user found with that email or invalid password.'
    end
  end
end

def sign_out
  remove_login_session
  flash[:notice] = {
    cls: 'info',
    msg: 'You have been successfully sign out',
  }
  redirect_to :root
end

def apply
  if request.post?
    @user = User.new(user_params)
    @user.status = 'NEW'
    for url in params[:user][:website].find_all{|url| !url.empty?}
      @user.websites << Website.new(url: url)
    end
    if @user.save
      UserMailer.welcome_email(@user).deliver
      flash[:notice] = {
        cls: 'info',
        msg: 'You have successfully applied for membership. You will receive an email shortly with more information.'
      }
      redirect_to :root
    end
  else
    @user = User.new
  end
end

def forgot
  @errors = {}
  if request.post?
    if params[:email].blank?
      @errors[:email] = 'Email is required.'
    end
    return unless @errors.empty?

    @user = User.find_by_email(params[:email])
    if @user
      @user.save_reset_token!
      UserMailer.reset_email(@user).deliver
    end
    flash[:notice] = {
      cls: 'info',
      msg: 'If an account with that email was found, we will send an email shortly with instructions on how to reset your password.'
    }
    redirect_to :root
  end
end

def reset
  @errors = {}
  @token = params[:token]
  @user = User.find_by_reset_token(@token)
  if !@user
    flash[:notice] = {
      cls: 'danger',
      msg: 'Invalid request, no user found to reset password.'
    }
    redirect_to :forgot
  end
  if request.post?
    if params[:password].blank?
      @errors[:password] = 'You must select a new password.'
    end
    return unless @errors.empty?

    @user.password = params[:password]
    @user.reset_token = nil
    if @user.save
      flash[:notice] = {
        cls: 'info',
        msg: 'Your password has been reset.'
      }
      redirect_to :root
    else
      @errors[:user] = 'There was an error saving your changes. Please try again later.'
    end
  end
end

private

def user_params
  params.require(:user).permit(:email, :username, :password, :name, :application)
end

end
