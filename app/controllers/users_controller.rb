class UsersController < ApplicationController

def moderate
  @users = User.where(status: 'NEW').paginate(page: params[:page])
  @users = @users.order('created_at DESC')
end

def reject
  @user = User.find(params[:id])
  @user.rejection = params[:rejection]
  @user.status = 'REJECTED'
  @user.save!
  UserMailer.rejection_email(@user).deliver
  render json: {
    msg: "#{@user.name} has been rejected."
  }
end

def approve
  @user = User.find(params[:id])
  @user.approval = params[:approval]
  @user.status = 'ACTIVE'
  @user.save!
  UserMailer.approval_email(@user).deliver
  render json: {
    msg: "#{@user.name} has been approved."
  }
end

end
