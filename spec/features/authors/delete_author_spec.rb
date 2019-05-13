require 'rails_helper'

RSpec.describe 'User can delete Author' do
  describe 'When I click on the delete author link' do



    before :each do
      @book_1 = Book.create!(title: "Book_1", pages: 300, year_published: 1999, book_img_url: "google.com")
      @book_2 = Book.create!(title: "Book_2", pages: 300, year_published: 1999, book_img_url: "google.com")
      @author_1 = Author.create(name: "Lisette Abrams")
      @author_2 = Author.create(name: "Larry Jenkins")
      @author_2.books << @book_1
      @author_1.books << @book_1
      @author_1.books << @book_2
      @review_1 = @book_1.reviews.create!(title: "Review_1", rating: 3, text: "Review 1 description")
      @review_2 = @book_1.reviews.create!(title: "Review_2", rating: 2, text: "Review 2 description")
      @review_3 = @book_1.reviews.create!(title: "Review_3", rating: 4, text: "Review 3 description")
    end

    it 'The author no longer exists in the database' do
      visit author_path(@author_1)

      within ".delete-author-link" do
        click_link('Delete this Author')
      end

      expect(current_path).to eq(books_path)
      expect(page).to_not have_content('Author(s): Lisette Abrams')
      expect(page).to_not have_content('Title: Book_1')
      expect(page).to_not have_content('Pages: 300')
      expect(page).to_not have_content('Year Published: 1999')
      expect(page).to_not have_content('Title: Book_1')
      expect(Author.all).to eq([@author_2])
    end
  end
end

# This link should return me to the book index page where I
# no longer see this author listed.
# If this author was the only author for any book, that book is also deleted.
# If this author co-authored a book with someone else, that book should also be deleted, but not the other author.
