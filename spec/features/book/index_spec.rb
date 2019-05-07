require 'rails_helper'
require 'pry'

RSpec.describe 'book index page', type: :feature do
  before :each do
    @book_1 = Book.create!(title: "Book_1", pages: 300, year_published: 1999, book_img_url: "google.com")
    @author_1 = Author.create!(name: "Bill")
    binding.pry
    @author_1.books << @book_1
  end

  it 'Index page shows a list of books' do
  end
end
