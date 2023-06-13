require 'rails_helper'

RSpec.describe 'Inlays' do
  describe 'basic routes' do
    let!(:book) { create(:book, publication: 'ltb', issue: 1, title: 'Micky Maus') }

    context 'accessible for all' do
      it 'can access the index path and see books' do
        get inlays_path
        expect(response).to have_http_status(:ok)
      end

      it 'can access the inlay show page' do
        get inlay_path(book)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
