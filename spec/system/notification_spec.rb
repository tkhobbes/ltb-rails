require 'rails_helper'

RSpec.describe 'Notifications' do
  describe 'mark notifications read' do
    let(:user) { create(:user) }
    let!(:book) { create(:book) }

    context 'book notifications' do
      let!(:notification) { create(:notification, recipient: user, params: { book: }, read_at: nil) }

      it 'marks a notification as read when the button is clicked' do
        visit root_path
        click_link I18n.t('devise.shared.links.sign_in')
        fill_in User.human_attribute_name(:email), with: user.email
        fill_in User.human_attribute_name(:password), with: user.password
        click_button I18n.t('devise.sessions.new.sign_in')
        sleep 5

        visit notifications_path
        click_button(title: I18n.t('notifications.notification.read'))
        sleep 1
        expect(notification.reload.read_at).not_to be_nil
      end

      it 'marks a notification as read when the notification is clicked in the menu' do
        visit root_path
        click_link I18n.t('devise.shared.links.sign_in')
        fill_in User.human_attribute_name(:email), with: user.email
        fill_in User.human_attribute_name(:password), with: user.password
        click_button I18n.t('devise.sessions.new.sign_in')
        sleep 5

        find_by_id('notifications_bell').hover
        click_link(notification.to_notification.message)
        sleep 1
        expect(notification.reload.read_at).not_to be_nil
      end
    end

    context 'error notifications' do
      let!(:notification) do
        create(
          :notification,
          recipient: user,
          type: 'ErrorNotification',
          params: {
            error: 'error',
            code: 'code'
          },
          read_at: nil
        )
      end

      it 'marks a notification as read in the menu even if the notification is an error notification' do
        visit root_path
        click_link I18n.t('devise.shared.links.sign_in')
        fill_in User.human_attribute_name(:email), with: user.email
        fill_in User.human_attribute_name(:password), with: user.password
        click_button I18n.t('devise.sessions.new.sign_in')
        sleep 5

        find_by_id('notifications_bell').hover
        click_link(notification.to_notification.message)
        sleep 1
        expect(notification.reload.read_at).not_to be_nil
      end
    end
  end
end
