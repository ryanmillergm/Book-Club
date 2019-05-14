class Book < ApplicationRecord
  has_many :author_books
  has_many :authors, through: :author_books, dependent: :destroy
  has_many :reviews, :dependent => :destroy

  validates_presence_of :title,
                        :pages,
                        :year_published

  before_save do |book|
    book.title = book.title.downcase.titleize
  end

  def top_review
    self.reviews.order("rating DESC").first
  end


  def average_rating
     self.reviews.average(:rating)
  end

  def self.sort_pages(pages)
    Book.order(pages)
  end

  def self.sort_reviews(sort_order)
    Book.joins(:reviews)
      .group(:id)
      .select("books.*, COUNT(reviews.id) AS review_count")
  end





end
