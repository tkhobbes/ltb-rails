# This is the main controller - the index action is the main page of the app
class BooksController < ApplicationController
  # this is the root path and can be accessed also for non-logged in users
  def index
    @books = Book.all.order(issue: :desc)
  end
end
