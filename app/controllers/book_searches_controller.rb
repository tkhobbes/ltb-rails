# this controller seraches a book and adds all data iteratively
class BookSearchesController < ApplicationController
  # display a search form
  def new; end

  #  display results and "create" button
  def create
    @results = Searcher::BookSearchScraper.new(params[:title], params[:number]).search_results
  end
end
