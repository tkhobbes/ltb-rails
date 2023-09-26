require 'rails_helper'

RSpec.describe 'Inlays' do
  describe 'filtering' do
    let!(:book) { create(:book, publication: 'ltb', issue: 1, title: 'Micky Maus') }
    let!(:book2) { create(:book, code: 'zzddee', publication: 'ltb', issue: 2, title: 'Micky Maus und Donald Duck') }

    context 'issues and publications' do
      it 'can filter by publication' do
        visit inlays_path
        select Book.human_enum_name(:publication, 'ltb'), from: 'book_publication'
        click_button I18n.t('inlays.index.filter')
        expect(page).to have_content(book.title)
        expect(page).to have_content(book2.title)
      end

      it 'can filter by issue' do
        visit inlays_path
        select Book.human_enum_name(:publication, 'ltb'), from: 'book_publication'
        fill_in 'book_issue', with: '2'
        click_button I18n.t('inlays.index.filter')
        expect(page).to have_content(book2.title)
      end
    end

    describe 'selecting' do
      it 'shows a book as selected when clicked' do
        visit inlays_path
        click_link book2.title
        expect(page.find("#selected li[data-controller='inlay-select']").text).to eq(book2.long_title)
      end

      it 'unselects a book when clicked a selected book' do
        visit inlays_path
        click_link book2.title
        click_link book2.title
        expect(page.has_no_css?("#selected li[data-controller='inlay-select']")).to be true
      end
    end
  end
end
