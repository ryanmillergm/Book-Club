class Review < ApplicationRecord

  belongs_to :user, optional: true

  validates_presence_of :title, :rating, :text
end
