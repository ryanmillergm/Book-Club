require 'rails_helper'

RSpec.describe 'A review can be successfully created' do
  describe 'When a user clicks on adds a new review' do
    before :each do
      @book_1 = Book.create!(title: "Book_1", pages: 300, year_published: 1999, book_img_url: "google.com")
      @user_1 = User.create!(name: "Johnny")
      @review_1 = @book_1.reviews.create!(title: "Review_1", rating: 3, text: "Review 1 description")
      @user_1.reviews << @review_1
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

    it 'Can only create one review per book per user.' do
      visit book_path(@book_1)

      within ".new-review-link" do
        click_link('Add a Review')
      end

      fill_in "Name", with: "Johnny"
      fill_in "Title", with: "Review_1"
      fill_in "Rating", with: 3
      fill_in "Text", with: "Another New review description."

      click_on "Create Review"

      expect(@book_1.reviews.count).to eq(1)
      expect(current_path).to eq(book_path(@book_1))
    end
  end
end
