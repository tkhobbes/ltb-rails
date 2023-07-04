# this controller creates a mega scraper to add a book and all stories and authors
class HolisticScrapersController < ApplicationController
  # create a new holistic scraper, get everything, and redirect
  def create
    book = Scraper::HolisticScraper.new(params[:code]).scrape
    respond_to do |format|
      format.html do
        if book.id.present?
          redirect_to book_path(book), notice: t('.all-added')
        else
          redirect_to new_books_search_path, notice: t('.not-added')
        end
      end
    end
  end
end
