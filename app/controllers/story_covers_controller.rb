# controller to attach portraits to artists
class StoryCoversController < ApplicationController
  def create
    story = Story.find(params[:story][:id])
    url = params[:story][:cover_url]
    result = Attacher::PictureAttach.new(url, story.cover).attach
    respond_to do |format|
      format.html do
        if result.created?
          story.update(cover_url: nil)
          redirect_to story_path(story), notice: result.message
        else
          redirect_to story_path(story), alert: result.message
        end
      end
    end
  end
end
