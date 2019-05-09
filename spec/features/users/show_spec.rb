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

      expect(page).to eq(user_path(@user_1))

    end
  end
end
