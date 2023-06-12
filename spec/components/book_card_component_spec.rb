# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookCardComponent, type: :component do
  describe 'rendering the component' do
    context 'attributes' do
      let(:book) { create(:book) }
      let(:book_no_pages) { create(:book, pages: nil) }
      let(:book_no_published) { create(:book, published: nil) }

      it 'renders published and pages as present' do
        render_inline(described_class.new(book:))
        expect(page).to have_content(
          "#{Book.human_attribute_name(:published)}: 1968 | #{Book.human_attribute_name(:pages)}: 260"
        )
      end

      it 'does only render published if pages not present' do
        render_inline(described_class.new(book: book_no_pages))
        expect(page).to have_content("#{Book.human_attribute_name(:published)}: 1968")
        expect(page).not_to have_content('|')
      end

      it 'does only render pages if published not present' do
        render_inline(described_class.new(book: book_no_published))
        expect(page).to have_content("#{Book.human_attribute_name(:pages)}: 260")
        expect(page).not_to have_content('|')
      end
    end

    context 'cover image' do
      let(:book) { create(:book) }

      # it 'renders the cover image as present' do
      # end

      it 'renders the fallback svg if no cover image present' do
        render_inline(described_class.new(book:))
        expect(page).to have_css('svg')
      end
    end
  end
end
