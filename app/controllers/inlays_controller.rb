# controller to show (& print) inlays
class InlaysController < ApplicationController
  # rubocop:disable Metrics/MethodLength
  def index
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'book_results',
          partial: 'books/inlay_table',
          locals: {
            books: Book.where(
              params[:book]
                .permit(:publication, :issue)
                .compact_blank
            )
          }
        )
      end
      format.html { @books = Book.all }
    end
  end
  # rubocop:enable Metrics/MethodLength

  def show
    @book = Book.find(params[:id])
  end

  private

  def inlay_params
    params.require(:book).permit(:publication, :issue)
  end
end
