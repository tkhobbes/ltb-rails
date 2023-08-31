# controller to show (& print) inlays
class InlaysController < ApplicationController
  def index
    respond_to do |format|
      format.turbo_stream
      format.html { @books = Book.all }
    end
  end

  def print
    # example ids: 357,374,415,365,363,362
    respond_to do |format|
      format.html { @books = Book.where(id: params[:ids].split(',')).includes(:stories) }
    end
  end

  # def inlay_params
  #   params.require(:book).permit(:publication, :issue)
  # end
end
