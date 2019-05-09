require 'rails_helper'

RSpec.describe 'A review can be successfully created' do
  describe 'When a user clicks on adds a new review' do
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

    it 'New User Creates a new review' do
      visit book_path(@book_1)


      within ".new-review-link" do
        click_link('Add a Review')
      end

      expect(current_path).to eq(new_book_review_path(@book_1))

      fill_in "Name", with: "lucky776"
      fill_in "Title", with: "New Review"
      fill_in "Rating", with: 3
      fill_in "Text", with: "New review description."

      click_on "Create Review"

      new_review = Review.last

      new_user = User.last

      expect(new_user.name).to eq('Lucky776')
      expect(new_review.title).to eq('New Review')
      expect(current_path).to eq(book_path(@book_1))

    end

    xit 'Can only create on review per user.' do

      visit book_path(@book_1)


      within ".new-review-link" do
        click_link('Add a Review')
      end

      fill_in "Name", with: "lucky777"
      fill_in "Title", with: "New Review"
      fill_in "Rating", with: 3
      fill_in "Text", with: "Another New review description."

      click_on "Create Review"

      visit book_path(@book_1)


      within ".new-review-link" do
        click_link('Add a Review')
      end

      fill_in "Name", with: "lucky777"
      fill_in "Title", with: "New Review"
      fill_in "Rating", with: 3
      fill_in "Text", with: "Another New review description."

      click_on "Create Review"

      binding.pry
      new_user = User.last

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