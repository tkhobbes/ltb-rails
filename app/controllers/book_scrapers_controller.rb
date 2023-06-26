# controller for artist scraper actions
class BookScrapersController < ApplicationController
  #  display a form to select an artist code to create them
  def new; end

  # show the artists found on INDUCKS for the code
  def create
    @book_scraper = Scraper::BookScraper.new(params[:code]).scrape
  end
end
