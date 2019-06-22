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


  def overall_average_rating
    reviews.average(:rating)
  end

  def average_rating
    self.reviews.average(:rating)
  end

  def top_three_reviews
    self.reviews.order(:rating).reverse.first(3)
  end

  def bottom_three_reviews
    self.reviews.order(:rating).first(3)
  end

  def top_review
    self.reviews.order("rating DESC").first
  end

  def self.sort_pages(pages)
    self.order(pages)
  end

  def self.sort_reviews(sort_reviews)
    joins(:reviews).group(:id).order("count(reviews) #{sort_reviews}")
  end

  def self.sort_ratings(sort_ratings)
    joins(:reviews).group(:id).order("AVG(reviews.rating) #{sort_ratings}")
  end

  def self.highest_rated_books
    joins(:reviews).group(:id).order('AVG(reviews.rating) DESC').limit(3)
  end

  def self.lowest_rated_books
    joins(:reviews).group(:id).order('AVG(reviews.rating) ASC').limit(3)
  end
end
