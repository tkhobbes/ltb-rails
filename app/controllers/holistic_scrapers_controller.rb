# this controller creates a mega scraper to add a book and all stories and authors
class HolisticScrapersController < ApplicationController
  # create a new holistic scraper, get everything, and redirect
  def create
    AddBookJob.perform_async(params[:code])
    redirect_to root_path, notice: t('.job-started')
  end
end
