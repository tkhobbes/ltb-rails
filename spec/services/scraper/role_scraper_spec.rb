require 'rails_helper'

RSpec.describe Scraper::RoleScraper do
  describe 'scraper' do
    context 'codes' do
      it 'returns data with a valid code' do
        result = Scraper::RoleScraper.new('I+TL++303-AP').scrape
        expect(result).to be_a(Hash)
        expect(result.keys).to include('writing')
        expect(result.values).to include('RSc')
      end

      it 'returns an empty hash with an invalid code' do
        result = Scraper::RoleScraper.new('totallyinvalid').scrape
        expect(result).to be_a(Hash)
        expect(result).to eq({})
      end

      it 'returns an empty hash when no code is provided' do
        result = Scraper::RoleScraper.new(nil).scrape
        expect(result).to be_a(Hash)
        expect(result).to eq({})
      end
    end
  end
end
