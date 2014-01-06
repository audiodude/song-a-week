class UserMailer < ActionMailer::Base
  default from: "no-reply@songs.0-z-0.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Song-A-Week')
  end

  def reset_email(user)
    @user = user
    mail(to: @user.email, subject: 'Reset your Song-A-Week password')
  end

  def approval_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your application for Song-A-Week has been approved!')
  end

  def rejection_email(user)
    @user = user
    mail(to: @user.email, subject: 'We\'re sorry, your application for Song-A-Week has been rejected')
  end
end
