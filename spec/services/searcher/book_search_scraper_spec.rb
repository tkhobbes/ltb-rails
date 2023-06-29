require 'rails_helper'

RSpec.describe Searcher::BookSearchScraper do
  describe 'scraper' do
    context 'codes' do
      it 'returns data with a valid publication and issue' do
        result = Searcher::BookSearchScraper.new('lustiges taschenbuch', '2').search_results
        expect(result).to be_a(Array)
        expect(result.first[:title]).to include('Lustiges Taschenbuch 2')
      end

      it 'works when no issue number is provided' do
        result = Searcher::BookSearchScraper.new('lustiges taschenbuch', '').search_results
        expect(result).to be_a(Array)
        expect(result.first[:title]).to include('Lustiges Taschenbuch')
      end

      it 'works when no publication is provided' do
        result = Searcher::BookSearchScraper.new('', '2').search_results
        expect(result).to be_a(Array)
        expect(result.first[:title]).to include('2')
      end

      it 'returns an empty array with an invalid publication' do
        result = Searcher::BookSearchScraper.new('totally invalid', '2').search_results
        expect(result).to be_a(Array)
        expect(result).to eq([])
      end
    end
  end
end
