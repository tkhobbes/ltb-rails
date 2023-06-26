# This is the main controller - the index action is the main page of the app
class BooksController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  # this is the root path and can be accessed also for non-logged in users
  def index
    @pagy, @books = pagy(Book.all.with_attached_cover.order(issue: :asc))
  end

  # the show method can also be accessed for non-logged in users
  def show
    @book = Book.find(params[:id])
  end

  # the new method is only available for logged in users
  def new
    @book = Book.new
  end

  # the edit method is only available for logged in users
  def edit
    @book = Book.find(params[:id])
  end

  # the create method is only available for logged in users
  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book), flash: { success: t('.created') }, status: :see_other
    else
      flash.now[:danger] = t('.not_created')
      render :new, status: :unprocessable_entity
    end
  end

  # the update method is only available for logged in users
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), status: :see_other, flash: { success: t('.updated') }
    else
      flash.now[:danger] = t('.not_updated')
      render :edit, status: :unprocessable_entity
    end
  end

  # the destroy method is only available for logged in users
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:success] = t('.deleted')
    redirect_to books_path, status: :see_other
  end

  private

  def book_params
    params.require(:book).permit(
      :code,
      :issue,
      :title,
      :published,
      :pages,
      :url,
      :cover,
      :publication,
      :cover_url
    )
  end
end
