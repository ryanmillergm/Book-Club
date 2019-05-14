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

  def average_rating
    self.reviews.average(:rating)
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

  def self.sort_reviews(sort_reviews)
    Book.joins(:reviews)
      .group(:id)
      .select("books.*, COUNT(reviews.id) AS review_count")
  end

  # def self.sort_ratings(sort_ratings)
  #   binding.pry
  # end

  def self.highest_rated_books
    joins(:reviews).group(:id).order('AVG(reviews.rating) DESC').limit(3)
  end

  def self.lowest_rated_books
    joins(:reviews).group(:id).order('AVG(reviews.rating) ASC').limit(3)
  end
end
