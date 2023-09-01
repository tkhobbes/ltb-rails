# controller to show (& print) inlays
class InlaysController < ApplicationController
  def index
    respond_to do |format|
      format.turbo_stream
      format.html { @books = Book.all }
    end
  end

  def print
    respond_to do |format|
      format.html { @books = Book.where(id: params[:ids].split(',')).includes(:stories) }
    end
  end
end
