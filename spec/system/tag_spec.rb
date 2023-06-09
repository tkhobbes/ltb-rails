require 'rails_helper'

RSpec.describe 'Tags' do
  describe 'stories', js: true do
    context 'in books' do
      let(:user) { create(:user) }
      let!(:book) { create(:book) }
      let!(:book2) { create(:book, title: 'Book 2', issue: 25) }
      let!(:story) { create(:story) }

      it 'displays a tag for the book if selected' do
        visit root_path
        click_link I18n.t('devise.shared.links.sign_in')
        fill_in User.human_attribute_name(:email), with: user.email
        fill_in User.human_attribute_name(:password), with: user.password
        click_button I18n.t('devise.sessions.new.sign_in')
        sleep 5

        click_on Story.model_name.human(count: 10)
        click_on Story.first.title
        click_on I18n.t('stories.show.edit')

        fill_in 'story_book_ids-ts-control', with: book.title
        find_by_id('story_book_ids-ts-control').native.send_keys(:return)
        expect(page).to have_css('.item')
      end

      it 'removes the tag for a book if deselected' do
        visit root_path
        click_link I18n.t('devise.shared.links.sign_in')
        fill_in User.human_attribute_name(:email), with: user.email
        fill_in User.human_attribute_name(:password), with: user.password
        click_button I18n.t('devise.sessions.new.sign_in')
        sleep 5

        Story.update(book_ids: [book.id])

        click_on Story.model_name.human(count: 10)
        click_on Story.first.title
        click_on I18n.t('stories.show.edit')

        click_link class: 'remove', match: :first
        expect(page).not_to have_css('.item')
      end

      it 'can show two tags if a story is in two books' do
        visit root_path
        click_link I18n.t('devise.shared.links.sign_in')
        fill_in User.human_attribute_name(:email), with: user.email
        fill_in User.human_attribute_name(:password), with: user.password
        click_button I18n.t('devise.sessions.new.sign_in')
        sleep 5

        click_on Story.model_name.human(count: 10)
        click_on Story.first.title
        click_on I18n.t('stories.show.edit')

        fill_in 'story_book_ids-ts-control', with: book.title
        find_by_id('story_book_ids-ts-control').native.send_keys(:return)
        fill_in 'story_book_ids-ts-control', with: book2.title
        find_by_id('story_book_ids-ts-control').native.send_keys(:return)
        expect(page).to have_css('.item', count: 2)
      end
    end
  end
end
