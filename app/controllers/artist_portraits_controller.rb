# controller to attach portraits to artists
class ArtistPortraitsController < ApplicationController
  def create
    artist = Artist.find(params[:artist][:id])
    url = params[:artist][:portrait_url]
    result = Attacher::PictureAttach.new(url, artist.portrait).attach
    respond_to do |format|
      format.html do
        if result.created?
          artist.update(portrait_url: nil)
          redirect_to artist_path(artist), notice: result.message
        else
          redirect_to artist_path(artist), alert: result.message
        end
      end
    end
  end
end
