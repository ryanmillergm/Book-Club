require 'rails_helper'

RSpec.describe 'author show page', type: :feature do
  before :each do
    @book_1 = Book.create!(title: "Book_1", pages: 300, year_published: 1999, book_img_url: "google.com")
    @book_2 = Book.create!(title: "Book_2", pages: 300, year_published: 1999, book_img_url: "google.com")
    @book_3 = Book.create!(title: "Book_3", pages: 300, year_published: 1999, book_img_url: "google.com")
    @author_1 = Author.create!(name: "Bill")
    @author_2 = Author.create!(name: "Jerry")
    @author_3 = Author.create!(name: "Tom")
    @author_1.books << @book_1
    @author_2.books << @book_2
    @author_3.books << @book_3
  end

  it 'Show page shows author and info' do
    visit author_path(@author_1)

    within "#author-id-#{@author_1.id}" do
      expect(page).to have_content('Name: Bill')
      expect(page).to_not have_content('Name: Jerry')
    end

  end
end

# User Story 14
# Author Show Page
#
# As a Visitor,
# When I visit an author's show page
# I see all book titles by that author
# Each book should show its year of publication
# Each book should show its number of pages
# Each book should show a list of any other authors
# (exclude this show page's author from that list)
