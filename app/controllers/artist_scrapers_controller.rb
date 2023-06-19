# controller for artist scraper actions
class ArtistScrapersController < ApplicationController
  #  display a form to select an artist code to create them
  def new; end

  # show the artists found on INDUCKS for the code
  def create
    @artist_scraper = Scraper::ArtistScraper.new(params[:code]).scrape
  end
end
