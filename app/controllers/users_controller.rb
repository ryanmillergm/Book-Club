class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    if params[:sort] == ['newest_first','DESC']
      @reviews = @user.reviews.newest_review_first
    elsif params[:sort] == ['oldest_first','ASC']
      @reviews = @user.reviews.oldest_review_first
    end
  end
end
