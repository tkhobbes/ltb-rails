# Background job to add a book from inducks to the database
class AddBookJob
  include Sidekiq::Job
  sidekiq_options retry: 3

  def perform(code)
    Scraper::HolisticScraper.new(code).scrape
  end
end
