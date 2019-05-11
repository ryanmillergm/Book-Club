require "rails_helper"

RSpec.describe "when a user visits user show page" do
  describe "a user sees a link next to ever review to delete review" do
    before :each do
      @book_1 = Book.create!(title: "Book_1", pages: 300, year_published: 1999, book_img_url: "google.com")
      @user_1 = User.create!(name: "Johnny")
      @user_2 = User.create!(name: "Bob")
      @user_3 = User.create!(name: "Henry")
      @review_1 = @book_1.reviews.create!(title: "Review_1", rating: 3, text: "Review 1 description")
      @review_2 = @book_1.reviews.create!(title: "Review_2", rating: 2, text: "Review 2 description")
      @review_3 = @book_1.reviews.create!(title: "Review_3", rating: 4, text: "Review 3 description")
      @user_1.reviews << @review_1
      @user_2.reviews << @review_2
      @user_3.reviews << @review_3
    end

    it "user show page has delete link" do
      visit user_path(@user_1)

      within "#review-id-#{@review_1.id}" do
        expect(page).to have_link("Delete Review")

        click_on 'Delete Review'
      end
      expect(current_path).to eq(user_path(@user_1))
      expect(page).to_not have_content(@review_1)
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
