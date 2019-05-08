class Book < ApplicationRecord
  has_many :author_books
  has_many :authors, through: :author_books
  has_many :reviews
  
  validates_presence_of :title,
                        :pages,
                        :year_published,
                        :book_img_url

end
