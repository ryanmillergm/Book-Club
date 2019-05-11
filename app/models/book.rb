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

end
