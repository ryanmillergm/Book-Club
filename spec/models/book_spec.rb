require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'Relationship' do
    it { should have_many :author_books }
    it { should have_many(:authors).through(:author_books) }
    it { should have_many :reviews }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :pages }
    it { should validate_presence_of :year_published }
    it { should validate_presence_of :book_img_url }
  end

  before :each do
    @book_1 = Book.create!(title: "Book_1", pages: 300, year_published: 1999, book_img_url: "google.com")
    @user_1 = User.create!(name: "Henry")
    @review_1 = @book_1.reviews.create!(title: "Review_1", rating: 3, text: "Review 1 description")
    @review_2 = @book_1.reviews.create!(title: "Review_2", rating: 2, text: "Review 2 description")
    @review_3 = @book_1.reviews.create!(title: "Review_3", rating: 4, text: "Review 3 description")
  end
end
