class Review < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :book

  validates_presence_of :title, :rating, :text

  def self.newest_review_first
    order('created_at ASC')
  end

  def self.oldest_review_first
    order('created_at DESC')
  end

end
