# controller to scrape all stories in a book
class BookStoriesScrapersController < ApplicationController
  def create
    # get book ID from params
    @book = Book.find(params[:book][:id])
    # get all stories in an array
    result = Scraper::BookStoryScraper.new(@book.code).scrape
    if result.created?
      result.data.each_with_index do |story_code, index|
        # check whether all stories are there otherwise create them
        story_id = Story.find_by(code: story_code)&.id ||
                   Story.create(Scraper::StoryScraper.new(story_code).scrape.story).id
        # create all book entries for all stories based on the array
        BookEntry.create(book_id: @book.id, story_id:, position: index + 1) unless story_id.nil?
        respond_to do |format|
          format.turbo_stream
        end
      end
    else
      redirect_to books_path(@book), alert: result.message
    end
  end
end
