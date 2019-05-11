require 'rails_helper'

RSpec.describe 'A user can delete a book' do
  context 'As a visitor' do
    describe 'when I click on the delete book link' do

      before :each do
        @book_1 = Book.create!(title: "Book_1", pages: 300, year_published: 1999, book_img_url: "google.com")
        @author_1 = Author.create!(name: "Jacobson")
        @author_1.books << @book_1
      end

      it 'The book is deleted' do
        visit book_path(@book_1)

        within('.delete-book-link') do
          click_link('Delete Book')
        end


        expect(current_path).to eq(books_path)
        expect(page).to_not have_xpath('//img[@src="google.com"]')
        expect(page).to_not have_content('Title: Book_1')
        expect(page).to_not have_content('Pages: 300')
        expect(page).to_not have_content('Year Published: 1999')
      end
    end
  end
end
#
#       As a Visitor,
# This link should return me to the book index page where I
# no longer see this book listed.
#
# (your controller may need to delete other content before you can delete the book)
