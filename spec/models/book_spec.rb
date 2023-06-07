require 'rails_helper'

RSpec.describe Book do
  describe 'validations and database constraints' do
    context 'database constraints' do
      it 'is not valid if the title is blank' do
        book = Book.new(issue: 1, published: 1970, pages: 260, url: 'abc')
        expect(book).not_to be_valid
      end

      it 'is not valid if the issue is blank' do
        book = Book.new(title: 'abc', published: 1970, pages: 260, url: 'abc')
        expect(book).not_to be_valid
      end

      it 'is valid if the title and the issue is given' do
        book = Book.new(title: 'abc', issue: 1, published: 1970, pages: 260, url: 'abc')
        expect(book).to be_valid
      end

      it 'cannot have two books with the same issue number' do
        b = create(:book)
        book = Book.new(title: 'abc', issue: b.issue)
        expect(book).not_to be_valid
      end
    end
  end

  describe 'model methods' do
    context 'core methods' do
      it 'returns the long title' do
        book = Book.new(title: 'abc', issue: 1, published: 1970, pages: 260, url: 'abc')
        expect(book.long_title).to eq('1 - abc')
      end
    end
  end
end
