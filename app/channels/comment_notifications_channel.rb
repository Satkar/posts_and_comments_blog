class CommentNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comment_notifications_channel"
  end

  def unsubscribed
  end
end
