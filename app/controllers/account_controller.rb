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
      set_login_session(@user)
      flash[:notice] = {
        cls: 'info',
        msg: 'You have been successfully logged in.'
      }
      redirect_to :root
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
    for url in params[:user][:website].find_all{|url| !url.empty?}
      @user.websites << Website.new(url: url)
    end
    if @user.save
      WelcomeMailer.welcome_email(@user).deliver
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
  if request.post?

  end
end

private

def user_params
  params.require(:user).permit(:email, :username, :password, :name, :application)
end

end
