require 'rails_helper'

RSpec.describe 'book index page', type: :feature do
  before :each do
    @book_1 = Book.create!(title: "Book_1", pages: 307, year_published: 1999, book_img_url: "google.com")
    @book_2 = Book.create!(title: "Book_2", pages: 302, year_published: 1999, book_img_url: "google.com")
    @book_3 = Book.create!(title: "Book_3", pages: 350, year_published: 1999, book_img_url: "google.com")
    @book_4 = Book.create!(title: "Book_4", pages: 300, year_published: 1999, book_img_url: "google.com")
    @author_1 = Author.create!(name: "Bill")
    @author_2 = Author.create!(name: "Jerry")
    @author_3 = Author.create!(name: "Tom")
    @author_1.books << @book_1
    @author_2.books << @book_2
    @author_3.books << @book_3

    @user_1 = User.create(name: "User_1")
    @user_2 = User.create(name: "User_2")
    @user_3 = User.create(name: "User_3")
    @user_4 = User.create(name: "User_4")
    @user_5 = User.create(name: "User_5")

    @review_1 = @book_1.reviews.create(title: 'title_1', rating: 5, text: 'body_1')
    @review_2 = @book_1.reviews.create(title: 'title_2', rating: 5, text: 'body_2')
    @review_3 = @book_1.reviews.create(title: 'title_3', rating: 3, text: 'body_3')
    @review_4 = @book_1.reviews.create(title: 'title_4', rating: 3, text: 'body_4')
    @review_5 = @book_2.reviews.create(title: 'title_5', rating: 5, text: 'body_5')
    @review_6 = @book_2.reviews.create(title: 'title_6', rating: 4, text: 'body_6')
    @review_7 = @book_2.reviews.create(title: 'title_7', rating: 3, text: 'body_7')
    @review_8 = @book_2.reviews.create(title: 'title_8', rating: 3, text: 'body_8')
    @review_9 = @book_3.reviews.create(title: 'title_9', rating: 5, text: 'body_9')
    @review_10 = @book_4.reviews.create(title: 'title_10', rating: 1, text: 'body_10')
    @review_11 = @book_4.reviews.create(title: 'title_11', rating: 1, text: 'body_11')

    @user_1.reviews = [@review_1, @review_2, @review_5, @review_6]
    @user_2.reviews = [@review_3, @review_4, @review_7, @review_8]
    @user_3.reviews = [@review_10, @review_11]
    @user_4.reviews << @review_9
  end

  it 'Index page shows a list of books' do
    visit '/books'

    within "#book-id-#{@book_1.id}" do
      expect(page).to have_xpath('//img[@src="google.com"]')
      expect(page).to have_content('Title: Book 1')
      expect(page).to have_content('Pages: 307')
      expect(page).to have_content('Year Published: 1999')
    end

    within "#book-id-#{@book_2.id}" do
      expect(page).to have_xpath('//img[@src="google.com"]')
      expect(page).to have_content('Title: Book 2')
      expect(page).to have_content('Pages: 302')
      expect(page).to have_content('Year Published: 1999')
    end

    within "#book-id-#{@book_3.id}" do
      expect(page).to have_xpath('//img[@src="google.com"]')
      expect(page).to have_content('Title: Book 3')
      expect(page).to have_content('Pages: 350')
      expect(page).to have_content('Year Published: 1999')
    end
  end

  it "Index page has link to book show page" do
    visit '/books'

    within "#book-id-#{@book_1.id}" do
      expect(page).to have_link("#{@book_1.title}", href: "/books/#{@book_1.id}")
    end

    within "#book-id-#{@book_2.id}" do
      expect(page).to have_link("#{@book_2.title}", href: "/books/#{@book_2.id}")
    end

    within "#book-id-#{@book_3.id}" do
      expect(page).to have_link("#{@book_3.title}", href: "/books/#{@book_3.id}")
    end
  end

  it "Index page shows statistics area" do

    visit books_path


    within ".statistics-area" do
      within "#highest-rated-books" do
        expect(page.body.index("top-book-card-#{@book_3.id}")).to be < page.body.index("top-book-card-#{@book_1.id}")
        expect(page.body.index("top-book-card-#{@book_1.id}")).to be < page.body.index("top-book-card-#{@book_2.id}")
      end

      within "#lowest-rated-books" do
        expect(page.body.index("btm-book-card-#{@book_4.id}")).to be < page.body.index("btm-book-card-#{@book_2.id}")
        expect(page.body.index("btm-book-card-#{@book_2.id}")).to be < page.body.index("btm-book-card-#{@book_1.id}")
      end

      within "#users-with-most-reviews" do
        reviewer_1 = @user_1.name
        reviewer_2 = @user_2.name
        reviewer_3 = @user_3.name
        expect(page.body.index(reviewer_1)).to be < page.body.index(reviewer_2)
        expect(page.body.index(reviewer_2)).to be < page.body.index(reviewer_3)
      end
    end
  end
end
