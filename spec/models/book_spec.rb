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
    @book_1 = Book.create(title: "Where the Crawdads Sing", pages: 384, year_published: 2018, book_img_url: "https://prodimage.images-bn.com/pimages/9780735219090_p0_v10_s550x406.jpg")

    @review_1 = @book_1.reviews.create(title: 'title_1', rating: 2, text: 'body_1')
    @review_2 = @book_1.reviews.create(title: 'title_2', rating: 5, text: 'body_2')
    @review_3 = @book_1.reviews.create(title: 'title_3', rating: 4, text: 'body_3')
    @review_4 = @book_1.reviews.create(title: 'title_4', rating: 5, text: 'body_4')
    @review_5 = @book_1.reviews.create(title: 'title_1', rating: 2, text: 'body_1')
    @review_6 = @book_1.reviews.create(title: 'title_2', rating: 5, text: 'body_2')
    @review_7 = @book_1.reviews.create(title: 'title_3', rating: 4, text: 'body_3')
    @review_8 = @book_1.reviews.create(title: 'title_4', rating: 2, text: 'body_4')
  end

    it '.top_three_reviews' do
      expected = [@review_2, @review_6, @review_4]
      actual = Book.highest_rated_books

      expect(actual).to eq(expected)
    end

    it '.bottom_three_reviews' do
      expected = [@review_1, @review_5, @review_7]
      actual = Book.lowest_rated_books

      expect(actual).to eq(expected)
    end

    it '.top_review' do
      expected = @review_2
      actual = @book_1.top_review

      expect(actual).to eq(expected)
    end
  end
end
