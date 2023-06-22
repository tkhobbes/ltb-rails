# controller for story scraper actions
class StoryScrapersController < ApplicationController
  #  display a form to select a story code to create them
  def new; end

  # show the stories found on INDUCKS for the code
  def create
    @story_scraper = Scraper::StoryScraper.new(params[:code]).scrape
  end
end
