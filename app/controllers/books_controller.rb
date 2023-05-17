# This is the main controller - the index action is the main page of the app
class BooksController < ApplicationController
  # this is the root path and can be accessed also for non-logged in users
  def index
    @books = Book.all.with_attached_cover.order(issue: :asc)
  end

  # the show method can also be accessed for non-logged in users
  def show
    @book = Book.find(params[:id])
  end

  # the new method is only available for logged in users
  def new; end

  # the edit method is only available for logged in users
  def edit; end
  # the create method is only available for logged in users
  def create; end

  # the update method is only available for logged in users
  def update; end

  # the destroy method is only available for logged in users
  def destroy; end

  private

  def book_params
    params.require(:book).permit(:issue, :title, :published, :pages, :url, :cover)
  end
end
