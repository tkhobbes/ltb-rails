require 'rails_helper'

RSpec.describe Scraper::ArtistScraper do
  describe 'scraper' do
    context 'codes' do
      it 'returns data with a valid code' do
        result = Scraper::ArtistScraper.new('RSc').scrape
        expect(result.valid?).to be true
        expect(result.artist[:name]).to eq('Romano Scarpa')
      end

      it 'returns a hash with empty values with an invalid code' do
        result = Scraper::ArtistScraper.new('totallyinvalid').scrape
        expect(result.valid?).to be false
      end

      it 'returns a hash with empty values when no code is provided' do
        result = Scraper::ArtistScraper.new(nil).scrape
        expect(result.valid?).to be false
      end
    end
  end
end
