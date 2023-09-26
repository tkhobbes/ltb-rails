# == Schema Information
#
# Table name: notifications
#
#  id             :bigint           not null, primary key
#  params         :jsonb
#  read_at        :datetime
#  recipient_type :string           not null
#  type           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  recipient_id   :bigint           not null
#
# Indexes
#
#  index_notifications_on_read_at    (read_at)
#  index_notifications_on_recipient  (recipient_type,recipient_id)
#
class Notification < ApplicationRecord
  include Noticed::Model
  belongs_to :recipient, polymorphic: true

  after_save_commit :broadcast_to_recipient

  private

  def broadcast_to_recipient
    broadcast_update_later_to(
      recipient,
      :notifications_top,
      target: 'notifications_bell',
      partial: 'notifications/notifications_bell',
      locals: {
        user: recipient
      }
    )
    broadcast_prepend_later_to(
      recipient,
      :public_notifications,
      target: 'notifications_menu',
      partial: 'notifications/notification_navi',
      locals: {
        notification: self
      }
    )
  end
end
