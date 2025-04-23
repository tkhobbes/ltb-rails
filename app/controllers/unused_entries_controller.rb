# This controller has no associated model; it is used to display lists of unused
# "things" in the system.
class UnusedEntriesController < ApplicationController
  def show
    if allowed_models.include? params[:id]
      @results = params[:id].safe_constantize.send(:no_items)
    else
      redirect_to root_path
    end
  end

  # remove entries with no items
  # rubocop:disable Metrics/AbcSize
  def destroy
    if allowed_models.include? params[:id]
      no_entries = params[:id].safe_constantize.send(:no_items)
      no_entries_size = no_entries.size
      no_entries.send(:no_items).destroy_all
      redirect_to root_path, notice: t('.destroyed', model: params[:id], amount: no_entries_size.to_s)
    else
      redirect_to root_path unless allowed_models.include? params[:id]
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  def allowed_models
    %w[Artist Story]
  end
end
