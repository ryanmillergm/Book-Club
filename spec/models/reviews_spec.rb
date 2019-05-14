require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :text }
  end

  describe 'instance-methods' do

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

      @user_1.reviews = [@review_1, @review_2, @review_3, @review_4, @review_5, @review_6, @review_7, @review_8]
    end

    it 'sorts chronologically newest to oldest' do
      expected = [@review_1, @review_2, @review_3, @review_4, @review_5, @review_6, @review_7, @review_8]
      actual = @user_1.reviews.newest_review_first
      expect(actual).to eq(expected)
    end

    it 'sorts chronologically oldest to newest' do
      expected = [@review_8, @review_7, @review_6, @review_5, @review_4, @review_3, @review_2, @review_1]
      actual = @user_1.reviews.oldest_review_first
      expect(actual).to eq(expected)
    end
  end
end
