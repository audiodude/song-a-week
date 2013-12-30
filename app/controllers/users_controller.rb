class UsersController < ApplicationController

def moderate
  @users = User.where(status: 'NEW').paginate(page: params[:page])
  @users = @users.order('created_at DESC')
end

end
