class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @user = User.new
    @review = Review.new
  end

  def create
    @book = Book.find(params[:book_id])
    if only_one_review(params) != true
      new_review = @book.reviews.create(review_params)
      new_user = User.create(user_params)
      binding.pry
      new_review.save!
      redirect_to book_path(@book)
    else
      redirect_to book_path(@book)
      flash[:notice] = "You can only create one review for this book"
    end
  end

  private

  def review_params
    params.require(:review).permit(:username, :title, :rating, :text)
  end

  def user_params
    params.require(:user).permit(:name)
  end


end
