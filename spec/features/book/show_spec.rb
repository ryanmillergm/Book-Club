require 'rails_helper'


RSpec.describe 'Book show page', type: :feature do
  before :each do
    @book_1 = Book.create!(title: "Book_1", pages: 300, year_published: 1999, book_img_url: "google.com")
    @author_1 = Author.create!(name: "Bill")
    @author_1.books << @book_1
    @user_1 = User.create!(name: "Henry")
    @review_1 = @book_1.reviews.create!(title: "Review_1", rating: 3, text: "Review 1 description")
    @review_2 = @book_1.reviews.create!(title: "Review_2", rating: 2, text: "Review 2 description")
    @review_3 = @book_1.reviews.create!(title: "Review_3", rating: 4, text: "Review 3 description")
    @user_1.reviews << @review_1
    @user_1.reviews << @review_2
    @user_1.reviews << @review_3
  end

  it 'Shows the book title, the authors and the number of pages in the book' do
    visit book_path(@book_1)

    within "#book-id-#{@book_1.id}" do
      expect(page).to have_xpath('//img[@src="google.com"]')
      expect(page).to have_content('Title: Book_1')
      expect(page).to have_content('Author(s): Bill')
      expect(page).to have_content('Pages: 300')
    end

    within "#review-id-#{@review_1.id}" do
      expect(page).to have_content('Title: Review_1')
      expect(page).to have_content('User: Henry')
      expect(page).to have_content('Rating: 3')
      expect(page).to have_content('Contents: Review 1 description')
    end

    within "#review-id-#{@review_2.id}" do
      expect(page).to have_content('Title: Review_2')
      expect(page).to have_content('User: Henry')
      expect(page).to have_content('Rating: 2')
      expect(page).to have_content('Contents: Review 2 description')
    end

    within "#review-id-#{@review_3.id}" do
      expect(page).to have_content('Title: Review_3')
      expect(page).to have_content('User: Henry')
      expect(page).to have_content('Rating: 4')
      expect(page).to have_content('Contents: Review 3 description')
      save_and_open_page
    end
  end
end

# User Story 10
# Book Show Page
#
#
# Each review will have a title and user, a numeric rating
# from 1 to 5, and text for the review itself, and all content
# must be present for each review.
