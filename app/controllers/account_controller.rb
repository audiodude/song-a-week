class AccountController < ApplicationController

def login

end

def apply
  if request.post?
    @user = User.new(user_params)
    if @user.save
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
