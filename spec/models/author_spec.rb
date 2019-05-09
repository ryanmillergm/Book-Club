require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'Relationship' do
    it { should have_many :author_books }
    it { should have_many(:books).through(:author_books) }
  end

  before :each do
    @book_1 = Book.create!(title: "Book_1", pages: 300, year_published: 1999, book_img_url: "google.com")
    @author_1 = Author.create!(name: "Bill")
    @review_1 = Review.create!(title: "Review_1", rating: 3, text: "Review 1 description")
    @review_2 = Review.create!(title: "Review_2", rating: 2, text: "Review 2 description")
    @review_3 = Review.create!(title: "Review_3", rating: 4, text: "Review 3 description")
    @book_1.reviews << @review_1
    @book_1.reviews << @review_2
    @book_1.reviews << @review_3
    @author_1.books << @book_1
  end

  describe 'Instance methods' do
    it 'top review for a book' do
      expect = @book_1.top_review
      expected = @review_3
      expect(expect).to eq(expected)
    end
  end
end
