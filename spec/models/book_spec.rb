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
  end

  before :each do
    @book_1 = Book.create!(title: "Book_1", pages: 307, year_published: 1999, book_img_url: "google.com")
    @book_2 = Book.create!(title: "Book_2", pages: 302, year_published: 1999, book_img_url: "google.com")
    @book_3 = Book.create!(title: "Book_3", pages: 350, year_published: 1999, book_img_url: "google.com")
    @user_1 = User.create!(name: "Henry")
    @review_1 = @book_1.reviews.create!(title: "Review_1", rating: 3, text: "Review 1 description")
    @review_2 = @book_1.reviews.create!(title: "Review_2", rating: 2, text: "Review 2 description")
    @review_3 = @book_1.reviews.create!(title: "Review_3", rating: 4, text: "Review 3 description")
    @review_4 = @book_3.reviews.create!(title: "Review_4", rating: 4, text: "Review 3 description")
  end

  describe 'class methods' do
    it 'sorts books by greatest to least pages' do
      expect = Book.sort_pages('pages ASC')
      expected = [@book_2, @book_1, @book_3]
      expect = expected
    end

    it 'sorts books by least pages to greatest' do
      expect = Book.sort_pages('pages DESC')
      expected = [@book_3, @book_1, @book_2]
      expect = expected
    end

    it 'sorts books by lowest number of reviews' do
      expect = Book.sort_reviews('review_count ASC')
      expected = expected = [@book_2, @book_3, @book_1]
      expect = expected
    end

    it 'sorts books by highest number of reviews' do
      expect = Book.sort_reviews('review_count DESC')
      expected = expected = [@book_3, @book_1, @book_2]
      expect = expected
    end

    it 'sorts books by lowest average rating' do
      expect = Book.sort_ratings('review_count ASC')
      expected = expected = [@book_2, @book_1, @book_3]
      expect = expected
    end

    # it 'sorts books by highest average rating' do
    #   expect = Book.sort_ratings('review_count DESC')
    #   expected = expected = [@book_2, @book_3, @book_1]
    #   expect = expected
    # end
  end

end
