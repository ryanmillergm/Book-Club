class Author < ApplicationRecord
  has_many :author_books
  has_many :books, through: :author_books

  before_save do |author|
    author.name = author.name.downcase.titleize
  end
end
