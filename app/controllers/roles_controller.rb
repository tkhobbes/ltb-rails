# controller to manage roles - used only within stories
class RolesController < ApplicationController
  before_action :authenticate_user!

  # new: renders a new form partial within the stories form
  def new
    @role = Role.new
    respond_to do |format|
      format.turbo_stream
    end
  end

  def edit
    @role = Role.find(params[:id])
    respond_to do |format|
      format.turbo_stream
    end
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('row_role',
                                                    partial: 'roles/story_subform', locals: { role: @role })
        end
      end
    end
  end

  def update
    @role = Role.find(params[:id])
    if @role.update(role_params)
      respond_to do |format|
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(helpers.dom_id(@role, :row),
                                                    partial: 'roles/story_subform', locals: { role: @role })
        end
      end
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@role)}-row") }
    end
  end

  private

  def role_params
    params.require(:role).permit(:task, :artist_id, :story_id)
  end
end
