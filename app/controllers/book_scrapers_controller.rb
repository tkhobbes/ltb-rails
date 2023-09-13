# controller for artist scraper actions
class BookScrapersController < ApplicationController
  #  display a form to select an artist code to create them
  def new; end

  # show the artists found on INDUCKS for the code
  def create
    result = Scraper::BookScraper.new(params[:code]).scrape
    if result.created?
      @book_scraper = result.data
    else
      redirect_to new_book_scraper_path, alert: result.message
    end
  end
end
