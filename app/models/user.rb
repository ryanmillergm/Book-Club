class User < ApplicationRecord

  has_many :reviews

  validates_presence_of :name

  def self.top_reviewers
    joins(:reviews).group(:id).order('count(reviews) DESC').limit(3)
  end
end
