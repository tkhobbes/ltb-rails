# To deliver this notification:
#
# BookNotification.with(post: @post).deliver_later(current_user)
# BookNotification.with(post: @post).deliver(current_user)
class BookNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database

  # Add required params
  #
  param :book

  # Define helper methods to make rendering easier
  def message
    t('.message', book: params[:book].title)
  end

  def url
    book_path(params[:book])
  end
end
