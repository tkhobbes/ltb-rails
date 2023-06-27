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

      it 'is not valid if two stories share the same position' do
        entry = BookEntry.create(story: create(:story), book: create(:book), position: 1)
        entry2 = BookEntry.new(story: create(:story, code: 'zzaa'), book: entry.book, position: 1)
        expect(entry).to be_valid
        expect(entry2).not_to be_valid
      end
    end
  end
end
