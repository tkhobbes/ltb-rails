# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookListComponent, type: :component do
  describe 'rendering component' do
    context 'attributes' do
      let(:book) { create(:book) }
      let(:book_no_pages) { create(:book, pages: nil) }
      let(:book_no_published) { create(:book, published: nil) }

      it 'shows code and pages if all are given' do
        render_inline(described_class.new(book:))
        expect(page).to have_content(
          "#{book.code} | #{book.pages} #{Book.human_attribute_name(:pages)}"
        )
      end

      it 'shows only code if pages are not given' do
        render_inline(described_class.new(book: book_no_pages))
        expect(page).to have_content('Hallo...hier Micky!')
        expect(page).not_to have_content(' | ')
      end
    end

    context 'cover images' do
      let(:book) { create(:book) }
      # add test for actual cover image

      it 'shows an svg placeholder if no cover image is attached' do
        render_inline(described_class.new(book:))
        expect(page).to have_css('svg')
      end
    end
  end
end
