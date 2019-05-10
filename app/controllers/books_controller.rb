class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
    @author = Author.new
  end

  def create
    @book = Book.find_or_create_by(book_params)
    @book.save
    create_authors
    redirect_to books_path
  end

  def create_authors
    params[:book][:authors].split(", ").map do |author|
      author = Author.find_or_create_by(name: author)
      author.save
      author.books << @book
    end
  end

  private


  def book_params
    params.require(:book).permit(:title, :pages, :year_published, :book_img_url)
  end
end
