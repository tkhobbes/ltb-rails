require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe Notification do
  context 'holistic scraper' do
    let!(:user) { create(:user) }

    it 'sends a book notification to users when a real book is scraped' do
      result = Scraper::HolisticScraper.new('de/LTB%20%20%202').scrape
      expect(Notification.last.type).to eq('BookNotification')
      expect(Notification.last.params[:book]).to eq(result)
      expect(Notification.last.recipient).to eq(User.last)
    end

    it 'sends an error notification to users when a book could not be scraped' do
      Scraper::HolisticScraper.new('totallyinvalid').scrape
      expect(Notification.last.type).to eq('ErrorNotification')
      expect(Notification.last.params[:code]).to eq('totallyinvalid')
      expect(Notification.last.recipient).to eq(User.last)
    end
  end
end
