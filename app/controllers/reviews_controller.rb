class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    @book = Book.find(params[:book_id])
    if only_one_review(params) != true
      new_review = @book.reviews.create(review_params)
      new_review.username = new_review.username.titleize
      new_review.save!
      redirect_to book_path(@book)
    else
      redirect_to book_path(@book)
      flash[:notice] = "You can only create one review for this book"
    end
  end

  def only_one_review(params)
    @book.reviews.each do |review|
      if review != []
        if review[:username] == params["review"][:username].titleize
          return true
        end
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:username, :title, :rating, :text)
  end


end
