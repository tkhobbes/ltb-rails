# controller for artist scraper actions
class BookScrapersController < ApplicationController
  #  display a form to select an artist code to create them
  def new; end

  # show the books found on INDUCKS for the code
  def create
    result = Scraper::BookScraper.new(params[:code]).scrape
    if result.valid?
      if Book.find_by(code: params[:code]).present?
        redirect_to new_book_scraper_path, alert: I18n.t('book_scrapers.create.exists')
      else
        @book_scraper = result.book
      end
    else
      redirect_to new_book_scraper_path, alert: result.message
    end
  end
end
