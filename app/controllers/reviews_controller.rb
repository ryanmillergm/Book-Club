class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @user = User.new
    @review = Review.new
  end

  def create
    @book = Book.find(params[:book_id])
    @user = User.find_or_create_by(user_params)
    @user.name = @user.name.titleize
    @user.save
    results = @book.reviews.find{|review| review.user.name == @user.name}
    if results.nil?
      new_review = @book.reviews.create(review_params)
      @user.reviews << new_review
      if new_review.save
        redirect_to book_path(@book)
      else
        render :new
      end
    else
      redirect_to book_path(@book)
    end
  end

  def destroy
    @review = Review.find(params[:book_id])
    @review.destroy
    redirect_to user_path(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(:username, :title, :rating, :text)
  end

  def user_params
    params[:review].require("user").permit(:name)
  end

end
