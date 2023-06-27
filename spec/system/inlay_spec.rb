require 'rails_helper'

RSpec.describe 'Inlays' do
  describe 'filtering' do
    let!(:book) { create(:book, publication: 'ltb', issue: 1, title: 'Micky Maus') }
    let!(:book2) { create(:book, code: 'zzddee', publication: 'ltb', issue: 2, title: 'Micky Maus und Donald Duck') }
    let!(:book3) { create(:book, code: '12345a', publication: 'micky_maus', issue: 1, title: 'test') }

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
  end
end
