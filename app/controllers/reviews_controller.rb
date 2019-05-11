class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @user = User.new
    @review = Review.new
  end

  def create
    @book = Book.find(params[:book_id])
    @users = User.all
    if new_user? == true
      @user = User.create!(user_params)
      @user.name = @user.name.titleize
      @user.save
    else
      @users.each do |user|
        if user.name == params["review"][:user]["name"].titleize
          @user = user
        end
      end
    end

    book = Book.find(params[:book_id])
    if only_one_review(@user, @book) != true
      new_review = @book.reviews.create(review_params)
      @user.reviews << new_review
      new_review.save!
      redirect_to book_path(@book)
    else
      redirect_to book_path(@book)
      flash[:notice] = "You can only create one review for this book"
    end
  end

  def new_user?
    @users.any? do |user|
      user.name != params["review"][:user]["name"].titleize
    end
  end

  def only_one_review(user, book)
    book.reviews.any? do |review|
      user.id == review.user_id
    end
  end

  def destroy

    @review = Review.find(params[:book_id])
    # binding.pry
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
