class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.micropost_notification.subject
  #
  def micropost_notification(user)
    @greeting = "Hi"
    @user = user

    user.followers.each do |t|
      mail to: t.email, subject: "New Tweet!"
    end
  end
end
