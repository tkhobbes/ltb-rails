# this is the controller that handles the stories
class StoriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  # index method is available for all users
  def index
    @pagy, @stories = pagy(Story.all.with_attached_cover.order(created_at: :desc))
  end

  # show method is available for all users
  def show
    @story = Story.includes(roles: :artist).find(params[:id])
  end

  # new method is only available for logged in users
  def new
    @story = Story.new
  end

  # edit method is only available for logged in users
  def edit
    @story = Story.find(params[:id])
    @roles = @story.roles.includes(:artists).all
  end

  # create method is only available for logged in users
  def create
    @story = Story.new(story_params)
    if @story.save
      redirect_to story_path(@story), flash: { success: t('.created') }, status: :see_other
    else
      flash.now[:danger] = t('.not_created')
      render :new, status: :unprocessable_entity
    end
  end

  # update method is only available for logged in users
  def update
    @story = Story.find(params[:id])
    if @story.update(story_params)
      redirect_to story_path(@story), status: :see_other, flash: { success: t('.updated') }
    else
      flash.now[:danger] = t('.not_updated')
      render :edit, status: :unprocessable_entity
    end
  end

  # destroy method is only available for logged in users
  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    flash[:success] = t('.deleted')
    redirect_to stories_path, status: :see_other
  end

  private

  def story_params
    params.require(:story).permit(
      :code,
      :url,
      :published,
      :origin,
      :pages,
      :title,
      :original_title,
      :cover,
      book_ids: []
    )
  end
end
