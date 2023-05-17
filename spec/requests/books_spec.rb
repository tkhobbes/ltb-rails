require 'rails_helper'

RSpec.describe 'Books' do
  describe 'authentication' do
    context 'does not need to log in' do
      it 'can access the book index path' do
        get books_path
        expect(response).to have_http_status(:success)
      end

      it 'can access the book show path' do
        book = create(:book)
        get book_path(book)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
