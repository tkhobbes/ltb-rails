# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArtistListComponent, type: :component do
  describe 'rendering the component' do
    context 'attributes' do
      let(:artist) { create(:artist) }
      let(:artist_no_born) { create(:artist, code: 'PMu', name: 'Paul Murphy', born: nil) }
      let(:artist_no_died) { create(:artist, code: 'FGo', name: 'Floyd Gottfredson', died: nil) }

      it 'shows life dates as provided' do
        render_inline(described_class.new(artist:))
        expect(page).to have_content(
          "#{Artist.human_attribute_name(:born)} #{artist.born} | #{Artist.human_attribute_name(:died)} #{artist.died}"
        )
      end

      it 'shows only birth year if no death year provided' do
        render_inline(described_class.new(artist: artist_no_died))
        expect(page).to have_content("#{Artist.human_attribute_name(:born)} #{artist.born}")
        expect(page).not_to have_content(Artist.human_attribute_name(:died))
      end

      it 'shows only death year if no birth year provided' do
        render_inline(described_class.new(artist: artist_no_born))
        expect(page).to have_content("#{Artist.human_attribute_name(:died)} #{artist.died}")
        expect(page).not_to have_content('|')
        expect(page).not_to have_content(Artist.human_attribute_name(:born))
      end
    end

    context 'portrait picture' do
      let(:artist) { create(:artist) }
      # add test for real picture

      it 'renders fallback svg if no portrait' do
        render_inline(described_class.new(artist:))
        expect(page).to have_css('svg')
      end
    end
  end
end
