class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    book = Book.new
  end

  def create
    binding.pry
    author = Author.find_or_create_by(title: book_params[:book][:authors])
    book = Book.create(book_params)
    author << book
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :pages, :year_published, :book_img_url, :authors)
  end
end
