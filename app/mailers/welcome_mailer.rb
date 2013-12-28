class WelcomeMailer < ActionMailer::Base
  default from: "no-reply@songs.0-z-0.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to Song-A-Week. Now start writing!')
  end
end
