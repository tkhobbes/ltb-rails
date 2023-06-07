# this is the controller that handles the stories
class ArtistsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  # index method is available for all users
  def index
    @pagy, @artists = pagy(Artist.all.with_attached_portrait.order(name: :asc))
  end

  # show method is available for all users
  def show
    @artist = Artist.includes(roles: :story).find(params[:id])
  end

  # new method is only available for logged in users
  def new
    @artist = Artist.new
  end

  # edit method is only available for logged in users
  def edit
    @artist = Artist.find(params[:id])
  end

  # create method is only available for logged in users
  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      redirect_to artist_path(@artist), flash: { success: t('.created') }, status: :see_other
    else
      flash.now[:danger] = t('.not_created')
      render :new, status: :unprocessable_entity
    end
  end

  # update method is only available for logged in users
  def update
    @artist = Artist.find(params[:id])
    if @artist.update(artist_params)
      redirect_to artist_path(@artist), status: :see_other, flash: { success: t('.updated') }
    else
      flash.now[:danger] = t('.not_updated')
      render :edit, status: :unprocessable_entity
    end
  end

  # destroy method is only available for logged in users
  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:success] = t('.deleted')
    redirect_to artists_path, status: :see_other
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :born, :died, :nationality, :portrait)
  end
end
