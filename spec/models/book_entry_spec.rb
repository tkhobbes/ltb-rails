require 'rails_helper'

RSpec.describe BookEntry do
  describe 'validations and database constraints' do
    context 'database constraints' do
      it 'is not valid if book is nil' do
        entry = BookEntry.new(story: create(:story))
        expect(entry).not_to be_valid
      end

      it 'is not valid if story is nil' do
        entry = BookEntry.new(book: create(:book))
        expect(entry).not_to be_valid
      end

      it 'is valid if book and story are given' do
        entry = BookEntry.new(story: create(:story), book: create(:book))
        expect(entry).to be_valid
      end
    end
  end
end
