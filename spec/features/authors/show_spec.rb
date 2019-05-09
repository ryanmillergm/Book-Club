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

  it "Show page shows books by author with title, pages and years published" do
    visit author_path(@author_1)

    within "#book-id-#{@book_1.id}" do
      expect(page).to have_xpath('//img[@src="google.com"]')
      expect(page).to have_content('Title: Book_1')
      expect(page).to have_content('Pages: 300')
      expect(page).to have_content('Year Published: 1999')
    end
  end

  it "Show page shows top review next to each book" do
    visit author_path(@author_1)

    within "#book-id-#{@book_1.id}" do
      expect(page).to have_content('Top Review:')

    # save_and_open_page
    end
  end
end

# User Story 4
# All author names are links to a show page
#
# As a visitor
# With the exception of an author's show page,
# Anywhere I see an author's name on the site,
# I can click on the name to go to that author's show page.

# User Story 15
# Author Show Page displays top review for each book
# As a Visitor,
# When I visit an author's show page,
# Next to each book written by that author
# I should see one of the highest rated reviews
# (review should contain the title, score, and user name)

# User Story 20
# User can delete an author
#
# As a Visitor,
# When I visit an author's show page,
# I see a link on the page to delete the author.
# This link should return me to the book index page where I
# no longer see this author listed.
# If this author was the only author for any book, that book is also deleted.
# If this author co-authored a book with someone else, that book should also be deleted, but not the other author.
#
# (you may need to delete other content before you can delete an author or book)
