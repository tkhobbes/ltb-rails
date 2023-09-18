# To deliver this notification:
#
# ErrorNotification.with(post: @post).deliver_later(current_user)
# ErrorNotification.with(post: @post).deliver(current_user)
class ErrorNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database

  # Add required params
  #
  param :error
  param :code

  # Define helper methods to make rendering easier
  def message
    t('.message', code: params[:code], error: params[:error])
  end

  def url
    root_path
  end
end
