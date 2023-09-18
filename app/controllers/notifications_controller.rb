# controller to show notifications
class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(recipient: current_user).order(created_at: :desc).includes([:recipient])
  end
end
