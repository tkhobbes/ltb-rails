require 'rails_helper'

RSpec.describe 'Flashes' do
  describe 'flash messages' do
    context 'login / logout' do
      let(:user) { create(:user) }

      it 'displays a success flash message upon login' do
        visit root_path
        click_link I18n.t('devise.shared.links.sign_in')
        fill_in User.human_attribute_name(:email), with: user.email
        fill_in User.human_attribute_name(:password), with: user.password
        click_button I18n.t('devise.sessions.new.sign_in')
        expect(page).to have_css('.notification.is-success')
        expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
      end

      it 'displays an error flash message upon login' do
        visit root_path
        click_link I18n.t('devise.shared.links.sign_in')
        fill_in User.human_attribute_name(:email), with: 'abc@example.com'
        fill_in User.human_attribute_name(:password), with: 'password'
        click_button I18n.t('devise.sessions.new.sign_in')
        expect(page).to have_css('.notification.is-danger')
        # interpolation of %{authentication_keys} not working properly
        # expect(page).to have_content(I18n.t('devise.failure.not_found_in_database'))
      end
    end

    context 'creation / deletion' do
      let(:user) { create(:user) }
      let!(:book) { create(:book) }

      it 'displays a success flash message when a book is created' do
        visit root_path
        click_link I18n.t('devise.shared.links.sign_in')
        fill_in User.human_attribute_name(:email), with: user.email
        fill_in User.human_attribute_name(:password), with: user.password
        click_button I18n.t('devise.sessions.new.sign_in')

        click_link I18n.t('shared.sidebar.new-book')
        fill_in Book.human_attribute_name(:issue), with: '987xyz'
        fill_in Book.human_attribute_name(:title), with: 'Test'
        click_button I18n.t('books.new.create')
        expect(page).to have_css('.notification.is-success')
        expect(page).to have_content(I18n.t('books.create.created'))
      end

      it 'displays a success flash message when a book is deleted' do
        visit root_path
        click_link I18n.t('devise.shared.links.sign_in')
        fill_in User.human_attribute_name(:email), with: user.email
        fill_in User.human_attribute_name(:password), with: user.password
        click_button I18n.t('devise.sessions.new.sign_in')

        click_on Book.model_name.human(count: 10)
        accept_alert(I18n.t('book_card_component.delete-confirm')) do
          click_link I18n.t('book_card_component.destroy'), match: :first
        end
        expect(page).to have_css('.notification.is-success')
        expect(page).to have_content(I18n.t('books.destroy.deleted'))
      end
    end
  end
end
