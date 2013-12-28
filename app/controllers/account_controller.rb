class AccountController < ApplicationController

def login

end

def apply
  if request.post?
    @user = User.new(user_params)
    for url in params[:user][:website].find_all{|url| !url.empty?}
      puts "Url is =====> #{url}"
      @user.websites << Website.new(url: url)
    end
    if @user.save
      WelcomeMailer.welcome_email(@user).deliver
      redirect_to :root
    end
  else
    @user = User.new
  end
end

private

def user_params
  params.require(:user).permit(:email, :username, :password, :name, :application)
end

end
