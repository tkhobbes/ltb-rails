# controller for story scraper actions
class StoryScrapersController < ApplicationController
  #  display a form to select a story code to create them
  def new; end

  # show the stories found on INDUCKS for the code
  def create
    result = Scraper::StoryScraper.new(params[:code]).scrape
    if result.valid?
      if Story.find_by(code: params[:code]).present?
        redirect_to new_story_scraper_path, alert: I18n.t('.story_scrapers.create.exists')
      else
        @story_scraper = result.story
      end
    else
      redirect_to new_story_scraper_path, alert: result.message
    end
  end
end
