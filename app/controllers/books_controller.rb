class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @books = Book.all
  end
end
