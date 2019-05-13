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

  def self.highest_rated_books
    joins(:reviews).order('rating').limit(3)
  end

  def self.lowest_rated_books
    joins(:reviews).order('rating desc').limit(3)
  end
end
