# controller to scrape all stories in a book
class BookStoriesScrapersController < ApplicationController
  def create
    # get book ID from params
    @book = Book.find(params[:book][:id])
    # get all stories in an array
    story_codes = Scraper::BookStoryScraper.new(@book.code).scrape
    story_codes.each do |story_code|
      # check whether all stories are there otherwise create them
      story_id = Story.find_by(code: story_code)&.id ||
                 Story.create(Scraper::StoryScraper.new(story_code).scrape).id
      # create all book entries for all stories based on the array
      BookEntry.create(book_id: @book.id, story_id:) unless story_id.nil?
      respond_to do |format|
        format.turbo_stream
      end
    end
  end
end
