# controller to attach portraits to artists
class BookCoversController < ApplicationController
  def create
    book = Book.find(params[:book][:id])
    url = params[:book][:cover_url]
    result = Attacher::PictureAttach.new(url, book.cover).attach
    respond_to do |format|
      format.html do
        if result.created?
          book.update(cover_url: nil)
          redirect_to book_path(book), notice: result.message
        else
          redirect_to book_path(book), alert: result.message
        end
      end
    end
  end
end
