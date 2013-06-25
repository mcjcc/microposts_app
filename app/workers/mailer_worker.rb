class MailerWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(current_user_id)
    current_user = User.find(current_user_id)
    current_user.followers.each do |follower|
        UserMailer.micropost_notification(current_user, follower, current_user.microposts.first).deliver
      end
  end

end
