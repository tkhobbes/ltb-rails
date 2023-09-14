# controller for artist scraper actions
class ArtistScrapersController < ApplicationController
  #  display a form to select an artist code to create them
  def new; end

  # show the artists found on INDUCKS for the code
  def create
    result = Scraper::ArtistScraper.new(params[:code]).scrape
    if result.valid?
      if Artist.find_by(code: result.artist[:code]).present?
        redirect_to new_artist_scraper_path, alert: I18n.t('artist_scrapers.create.exists')
      else
        @artist_scraper = result.artist
      end
    else
      redirect_to new_artist_scraper_path, alert: result.message
    end
  end
end
