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

  describe 'top_3_statistics' do
    before :each do
    @book_1 = Book.create(title: "Book 1", pages: 384, year_published: 2018, book_img_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
    @book_2 = Book.create(title: "Book 2", pages: 385, year_published: 2018, book_img_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
    @book_3 = Book.create(title: "Book 3", pages: 386, year_published: 2018, book_img_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
    @book_4 = Book.create(title: "Book 4", pages: 387, year_published: 2018, book_img_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
    @review_1 = @book_1.reviews.create(title: 'title_1', rating: 5, text: 'body_1')
    @review_2 = @book_1.reviews.create(title: 'title_2', rating: 4, text: 'body_2')
    @review_3 = @book_2.reviews.create(title: 'title_3', rating: 4, text: 'body_3')
    @review_4 = @book_2.reviews.create(title: 'title_4', rating: 4, text: 'body_4')
    @review_5 = @book_3.reviews.create(title: 'title_5', rating: 3, text: 'body_1')
    @review_6 = @book_3.reviews.create(title: 'title_6', rating: 3, text: 'body_2')
    @review_7 = @book_4.reviews.create(title: 'title_7', rating: 3, text: 'body_3')
    @review_8 = @book_4.reviews.create(title: 'title_8', rating: 2, text: 'body_4')

    @user_1 = User.create(name: "Jake")
    @user_2 = User.create(name: "Ben")
    @user_3 = User.create(name: "Harry")
    @user_4 = User.create(name: "Samantha")
    @user_5 = User.create(name: "Nancy")

    @user_1.reviews << [@review_1, @review_2, @review_3, @review_4]
    @user_2.reviews << [@review_5, @review_6, @review_7]
    @user_3.reviews << @review_8
  end

    it '.highest_rated_books' do
      expected = [@book_1, @book_2, @book_3]
      actual = Book.highest_rated_books
      expect(actual).to eq(expected)
    end

    it '.lowest_rated_books' do
      expected = [@book_4, @book_3, @book_2]
      actual = Book.lowest_rated_books
      expect(actual).to eq(expected)
    end

    it '.top_reviewers' do
      expected = [@user_1, @user_2, @user_3]
      actual = User.top_reviewers
      expect(actual).to eq(expected)
    end

    it '.top_review' do
      expected = @review_1
      actual = @book_1.top_review
      expect(actual).to eq(expected)
    end
  end

  describe 'Sort Methods' do
    before :each do
      @book_1 = Book.create(title: "Book 1", pages: 384, year_published: 2018, book_img_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
      @book_2 = Book.create(title: "Book 2", pages: 385, year_published: 2018, book_img_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
      @book_3 = Book.create(title: "Book 3", pages: 386, year_published: 2018, book_img_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
      @book_4 = Book.create(title: "Book 4", pages: 387, year_published: 2018, book_img_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
      @review_1 = @book_1.reviews.create(title: 'title_1', rating: 5, text: 'body_1')
      @review_2 = @book_2.reviews.create(title: 'title_2', rating: 4, text: 'body_2')
      @review_3 = @book_2.reviews.create(title: 'title_3', rating: 4, text: 'body_3')
      @review_4 = @book_3.reviews.create(title: 'title_4', rating: 4, text: 'body_4')
      @review_5 = @book_3.reviews.create(title: 'title_5', rating: 3, text: 'body_1')
      @review_6 = @book_3.reviews.create(title: 'title_6', rating: 3, text: 'body_2')
      @review_7 = @book_4.reviews.create(title: 'title_7', rating: 3, text: 'body_3')
      @review_8 = @book_4.reviews.create(title: 'title_8', rating: 2, text: 'body_4')
      @review_9 = @book_4.reviews.create(title: 'title_8', rating: 2, text: 'body_4')
      @review_10 = @book_4.reviews.create(title: 'title_8', rating: 2, text: 'body_4')

      @user_1 = User.create(name: "Jake")
      @user_2 = User.create(name: "Ben")
      @user_3 = User.create(name: "Harry")
      @user_4 = User.create(name: "Samantha")
      @user_5 = User.create(name: "Nancy")

      @user_1.reviews << [@review_1, @review_2, @review_3, @review_4]
      @user_2.reviews << [@review_5, @review_6, @review_7]
      @user_3.reviews << @review_8
    end

    it 'sorts books by greatest to least pages' do
      expected = [@book_4, @book_3, @book_2, @book_1]
      actual = Book.sort_pages('pages DESC')
      expect(actual).to eq(expected)
    end

    it 'sorts books by least pages to greatest' do
      expected = [@book_1, @book_2, @book_3, @book_4]
      actual = Book.sort_pages('pages ASC')
      expect(actual).to eq(expected)
    end

    it 'sorts books by highest number of reviews' do
      expected = [@book_4, @book_3, @book_2, @book_1]
      actual = Book.sort_reviews('DESC')
      expect(actual).to eq(expected)
    end

    it 'sorts books by lowest number of reviews' do
      expected = [@book_1, @book_2, @book_3, @book_4]
      actual = Book.sort_reviews('ASC')
      expect(actual).to eq(expected)
    end

    it 'sorts books by highest average rating' do
      expected = [@book_1, @book_2, @book_3, @book_4]
      actual = Book.sort_ratings('DESC')
      expect(actual).to eq(expected)
    end

    it 'sorts books by lowest average rating' do
      expected = [@book_4, @book_3, @book_2, @book_1]
      actual = Book.sort_ratings('ASC')
      expect(actual).to eq(expected)
    end
  end

  describe 'book statistics methods' do
    before :each do
      @book_1 = Book.create(title: "Book 1", pages: 384, year_published: 2018, book_img_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")
      @review_1 = @book_1.reviews.create(title: 'title_1', rating: 5, text: 'body_1')
      @review_2 = @book_1.reviews.create(title: 'title_2', rating: 4, text: 'body_2')
      @review_3 = @book_1.reviews.create(title: 'title_3', rating: 3, text: 'body_3')
      @review_4 = @book_1.reviews.create(title: 'title_4', rating: 2, text: 'body_4')
      @review_5 = @book_1.reviews.create(title: 'title_5', rating: 1, text: 'body_1')


      @user_1 = User.create(name: "Jake")
      @user_2 = User.create(name: "Ben")
      @user_3 = User.create(name: "Harry")
      @user_4 = User.create(name: "Samantha")

      @user_1.reviews = [@review_1, @review_2]
      @user_2.reviews << @review_3
      @user_3.reviews << @review_4
      @user_4.reviews << @review_5
    end

    it 'sorts by top three reviews' do
      expected = [@review_1, @review_2, @review_3]
      actual = @book_1.top_three_reviews
      expect(actual).to eq(expected)
    end

    it 'sorts by bottom three reviews' do
      expected = [@review_5, @review_4, @review_3]
      actual = @book_1.bottom_three_reviews
      expect(actual).to eq(expected)
    end

    it 'has overall average rating of all reviews for this book' do
      expected = 3
      actual = @book_1.overall_average_rating
      expect(actual).to eq(expected)
    end
  end
end
