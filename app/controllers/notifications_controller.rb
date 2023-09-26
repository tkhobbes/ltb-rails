# controller to show notifications
class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(recipient: current_user).order(created_at: :desc).includes([:recipient])
  end

  def read
    @notification = Notification.find(params[:id])
    return if @notification.read_at.present?

    @notification.update(read_at: Time.zone.now)
    if params[:menu] == 'true'
      head(:no_content)
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@notification, partial: 'notifications/notification',
                                                                   locals: { notification: @notification })
        end
      end
    end
  end

  def unread
    @notification = Notification.find(params[:id])
    @notification.update(read_at: nil)
  end
end
