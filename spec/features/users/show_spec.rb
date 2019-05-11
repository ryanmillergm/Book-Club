require 'rails_helper'

RSpec.describe 'User Show Page' do
  describe 'When a user clicks on a link for a user' do
    before :each do
      @book_1 = Book.create!(title: "Book_1", pages: 300, year_published: 1999, book_img_url: "google.com")
      @book_2 = Book.create!(title: "Book_2", pages: 300, year_published: 1999, book_img_url: "google.com")
      @book_3 = Book.create!(title: "Book_3", pages: 300, year_published: 1999, book_img_url: "google.com")
      @user_1 = User.create!(name: "Johnny")
      @review_1 = @book_1.reviews.create!(title: "Review_1", rating: 3, text: "Review 1 description")
      @review_2 = @book_2.reviews.create!(title: "Review_2", rating: 2, text: "Review 2 description")
      @review_3 = @book_3.reviews.create!(title: "Review_3", rating: 4, text: "Review 3 description")
      @user_1.reviews << @review_1
      @user_1.reviews << @review_2
      @user_1.reviews << @review_3
    end

    it 'goes to the user show page' do
      visit book_path(@book_1)

      within ".review-description" do
        within "#review-id-#{@review_1.id}" do
          click_link("#{@user_1.name}")
        end
      end

      expect(current_path).to eq(user_path(@user_1))
    end

    it 'It sees all of the users information' do

      visit user_path(@user_1)

      within ".user-card" do
        expect(page).to have_content("User: #{@user_1.name}")
      end

      within "#review-id-#{@review_1.id}" do
        expect(page).to have_content("Title: #{@review_1.title}")
        expect(page).to have_content("User: #{@user_1.name}")
        expect(page).to have_content("Rating: #{@review_1.rating}")
        expect(page).to have_xpath('//img[@src="google.com"]')
        expect(page).to have_link("#{@book_1.title}")
        expect(page).to have_content("Contents: #{@review_1.text}")
      end

      within "#review-id-#{@review_2.id}" do
        expect(page).to have_content("Title: #{@review_2.title}")
        expect(page).to have_content("User: #{@user_1.name}")
        expect(page).to have_content("Rating: #{@review_2.rating}")
        expect(page).to have_xpath('//img[@src="google.com"]')
        expect(page).to have_link("#{@book_2.title}")
        expect(page).to have_content("Contents: #{@review_2.text}")
      end

      within "#review-id-#{@review_3.id}" do
        expect(page).to have_content("Title: #{@review_3.title}")
        expect(page).to have_content("User: #{@user_1.name}")
        expect(page).to have_content("Rating: #{@review_3.rating}")
        expect(page).to have_xpath('//img[@src="google.com"]')
        expect(page).to have_link("#{@book_3.title}")
        expect(page).to have_content("Contents: #{@review_3.text}")
      end
    end
  end
end

# User Story 18
# User can delete a book review
#
# As a Visitor,
# When I visit a user's show page,
# I see a link next to each review to delete the review.
# When I delete a review I am returned to the user's show page
# Then I should no longer see that review.



# I should see all reviews that this
# user has written.
# Each review shows:
# - the title of the review
# - the description of the review
# - the rating of the review
# - the title of the book
# - the thumbnail image for the book
# - the date the review was written
