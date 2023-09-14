# Standard Rails application helper
module ApplicationHelper
  include Pagy::Frontend

  # render flash messages - needed for hot_flash
  def render_flash
    return if @_flash_rendered

    render partial: 'shared/flashes'
  end
end
