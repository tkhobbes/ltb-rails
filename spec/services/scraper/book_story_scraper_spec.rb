require 'rails_helper'

RSpec.describe Scraper::BookStoryScraper do
  describe 'scraper' do
    context 'codes' do
      it 'returns data with a valid code' do
        result = Scraper::BookStoryScraper.new('de/LTB%20%20%202').scrape
        expect(result.created?).to be true
        expect(result.data).to include('I+TL++303-AP')
      end

      it 'returns an empty array with an invalid code' do
        result = Scraper::BookStoryScraper.new('totallyinvalid').scrape
        expect(result.created?).to be false
      end

      it 'returns am empty array when no code is provided' do
        result = Scraper::BookStoryScraper.new(nil).scrape
        expect(result.created?).to be false
      end
    end
  end
end
