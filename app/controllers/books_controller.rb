class BooksController < ApplicationController

  def index
    @books = Book.all
    @sort = params[:sort]
    @top_reviewers = User.top_reviewers
    if @sort != nil
     if @sort == "pages_asc"
       @books = Book.sort_pages('pages ASC')
     elsif @sort == "pages_desc"
       @books = Book.sort_pages('pages DESC')
     elsif @sort == "reviews_asc"
       @books == Book.sort_reviews('ASC')
     elsif @sort == "reviews_desc"
       @books = Book.sort_reviews('DESC')
     elsif @sort == "ratings_desc"
       @books = Book.sort_ratings('DESC')
     elsif @sort == "ratings_asc"
       @books = Book.sort_ratings('ASC')
     else
       @books = Book.all
     end
   end

  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
    @author = Author.new
  end

  def create
    if params["book"]["book_img_url"] == ''
      params["book"]["book_img_url"] = "https://ibf.org/site_assets/img/placeholder-book-cover-default.png"
    end
    @book = Book.find_or_create_by(book_params)
    @book.save
    create_authors

    redirect_to book_path(@book)
  end

  def create_authors
    params[:book][:authors].split(", ").map do |author|
      author = Author.find_or_create_by(name: author)
      author.save
      author.books << @book
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :pages, :year_published, :book_img_url)
  end
end
