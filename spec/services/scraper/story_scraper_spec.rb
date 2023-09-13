require 'rails_helper'

RSpec.describe Scraper::StoryScraper do
  describe 'scraper' do
    context 'codes' do
      it 'returns data with a valid code' do
        result = Scraper::StoryScraper.new('I+TL++303-AP').scrape
        expect(result.valid?).to be true
        expect(result.story[:original_title]).to eq('Topolino e la fiamma eterna di Kalhoa')
      end

      it 'returns a hash with empty values with an invalid code' do
        result = Scraper::StoryScraper.new('totallyinvalid').scrape
        expect(result.valid?).to be false
      end

      it 'returns a hash with empty values when no code is provided' do
        result = Scraper::StoryScraper.new(nil).scrape
        expect(result.valid?).to be false
      end
    end
  end
end
