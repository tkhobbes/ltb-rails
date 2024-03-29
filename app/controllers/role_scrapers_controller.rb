# actions to scrape roles
class RoleScrapersController < ApplicationController
  def create
    # get story ID from params
    @story = Story.find(params[:story][:id])
    result = Scraper::RoleScraper.new(@story.code).scrape
    if result.valid?
      result.roles.each do |task, artist_code|
        # check whether all artists are there otherwise create them
        artist_id = Artist.find_by(code: artist_code)&.id ||
                    Artist.create(Scraper::ArtistScraper.new(artist_code).scrape.artist).id
        # create all roles for all artists based on the hash
        Role.create(story_id: @story.id, task:, artist_id:) unless artist_id.nil?
        respond_to do |format|
          format.turbo_stream
        end
      end
    else
      redirect_to story_path(@story), alert: result.message
    end
    # get all roles in a hash (role name => artist code)
  end
end
