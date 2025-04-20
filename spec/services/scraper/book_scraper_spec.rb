require 'rails_helper'

RSpec.describe Scraper::BookScraper do
  describe 'scraper' do
    context 'codes' do
      it 'returns data with a valid code' do
        result = Scraper::BookScraper.new('de/LTB%20%20%202').scrape
        expect(result.valid?).to be true
        expect(result.book[:title]).to eq('"Hallo...hier Micky!"')
      end

      it 'returns a hash with empty values with an invalid code' do
        result = Scraper::BookScraper.new('totallyinvalid').scrape
        expect(result.valid?).to be false
      end

      it 'returns a hash with empty values when no code is provided' do
        result = Scraper::BookScraper.new(nil).scrape
        expect(result.valid?).to be false
      end
    end
  end
end
