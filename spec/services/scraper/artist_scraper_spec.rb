require 'rails_helper'

RSpec.describe Scraper::ArtistScraper do
  describe 'scraper' do
    context 'codes' do
      it 'returns data with a valid code' do
        result = Scraper::ArtistScraper.new('RSc').scrape
        expect(result).to be_a(Hash)
        expect(result[:name]).to eq('Romano Scarpa')
      end

      it 'returns a hash with empty values with an invalid code' do
        result = Scraper::ArtistScraper.new('totallyinvalid').scrape
        expect(result).to be_a(Hash)
        expect(result[:name]).to eq('')
      end

      it 'returns a hash with empty values when no code is provided' do
        result = Scraper::ArtistScraper.new(nil).scrape
        expect(result).to be_a(Hash)
        expect(result[:name]).to eq('')
      end
    end
  end
end
