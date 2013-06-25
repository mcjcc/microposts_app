class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.micropost_notification.subject
  #
  def micropost_notification(poster, follower, micropost)
    @greeting = "Hi"
    @follower = follower
    @micropost = micropost
    @poster = poster

    
    mail to: follower.email, subject: "New Tweet!"
    
  end
end
