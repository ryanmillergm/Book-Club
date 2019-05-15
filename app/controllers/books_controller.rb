class BooksController < ApplicationController

  def index
    @books = Book.all
    @sort = params[:sort]
    @top_reviewers = User.top_reviewers
    @highest_rated_books = @books.highest_rated_books
    @lowest_rated_books = @books.lowest_rated_books
    if @sort != nil

     if @sort == "pages_desc"
       @books = Book.all.sort_pages('pages DESC')
     elsif @sort == "pages_asc"
       @books = Book.all.sort_pages('pages ASC')
     elsif @sort == "reviews_desc"
       @books = Book.all.sort_reviews('DESC')
     elsif @sort == "reviews_asc"
       @books = Book.all.sort_reviews('ASC')
     elsif @sort == "best_ratings"
       @books = Book.all.sort_ratings('DESC')
     elsif @sort == "worst_ratings"
       @books = Book.all.sort_ratings('ASC')
     else
       @books = Book.all
     end
   end

  end

  def show
    @book = Book.find(params[:id])
    @top_three_reviews = @book.top_three_reviews
    @bottom_three_reviews = @book.bottom_three_reviews
    @overall_average_rating = @book.overall_average_rating
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
