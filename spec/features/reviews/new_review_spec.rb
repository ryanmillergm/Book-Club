require 'rails_helper'

RSpec.describe 'A review can be successfully created' do
  describe 'When a user clicks on adds a new review' do
    before :each do
      @book_1 = Book.create!(title: "Book_1", pages: 300, year_published: 1999, book_img_url: "google.com")
    end

    it 'Creates a new review' do
      visit book_path(@book_1)


      within ".new-review-link" do
        click_link('Add a Review')
      end

      expect(current_path).to eq(new_book_review_path(@book_1))

      fill_in "Title", with: "New Review"
      fill_in "Rating", with: 3
      fill_in "Text", with: "New review description."

      click_on "Create Review"

      new_review = @book_1.reviews.last

      expect(new_review.title).to eq('New Review')
      expect(new_review.username).to eq('Lucky777')
      expect(current_path).to eq(book_path(@book_1))

      visit book_path(@book_1)


      within ".new-review-link" do
        click_link('Add a Review')
      end

      fill_in "Username", with: "lucky777"
      fill_in "Title", with: "New Review"
      fill_in "Rating", with: 3
      fill_in "Text", with: "Another New review description."

      click_on "Create Review"

      expect(@book_1.reviews.count).to eq(1)
      expect(current_path).to eq(book_path(@book_1))
    end
  end
end
# On this new page, I see a form where I can enter:
# - a review title
# - a username as a string
# - a numeric rating that can only be a number from 1 to 5
# - some text for the review itself
# When the form is submitted, I should return to that book's
# show page and I should see my review text.
#
# User names should be converted to Title Case before saving.
# User names should be unique for that book (a user can leave only one review per book)
