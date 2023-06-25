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

    context 'can perform CRUD actions when logged in' do
      let(:user) { create(:user) }
      let(:book) { create(:book) }

      it 'can create a new book if logged in' do
        sign_in user
        get new_book_path
        expect(response).to have_http_status(:success)
        post books_path, params: { book: { code: 'abcd', issue: 25, title: 'Test Title' } }
        expect(Book.last.title).to eq('Test Title')
      end

      it 'can edit a book if logged in' do
        sign_in user
        get edit_book_path(book)
        expect(response).to have_http_status(:success)
        patch book_path(book), params: { book: { title: 'Test Title' } }
        expect(book.reload.title).to eq('Test Title')
      end

      it 'can delete a book if logged in' do
        sign_in user
        delete book_path(book)
        expect(response).to have_http_status(:redirect)
        expect(Book.where(id: book.id).count).to eq(0)
      end
    end

    context 'cannot perform CRUD actions when logged in' do
      let(:book) { create(:book) }

      it 'cannot create a new book if not logged in' do
        get new_book_path
        expect(response).not_to have_http_status(:success)
      end

      it 'cannot edit a book if not logged in' do
        get edit_book_path(book)
        expect(response).not_to have_http_status(:success)
      end

      it 'cannot delete a book if not logged in' do
        delete book_path(book)
        expect(response).not_to have_http_status(:success)
      end
    end
  end
end
