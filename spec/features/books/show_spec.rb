require 'rails_helper'

RSpec.describe 'book show page', type: :feature do
  before :each do
    @book_1 = Book.create!(title: "Book_1", pages: 300, year_published: 1999, book_img_url: "google.com")
    @book_2 = Book.create!(title: "Book_2", pages: 300, year_published: 1999, book_img_url: "google.com")
    @book_3 = Book.create!(title: "Book_3", pages: 300, year_published: 1999, book_img_url: "google.com")
    @author_1 = Author.create!(name: "Bill")
    @author_2 = Author.create!(name: "Jerry")
    @author_3 = Author.create!(name: "Tom")
    @author_1.books << @book_1
    @author_2.books << @book_2
    @author_3.books << @book_3
    @user_1 = User.create!(name: "Henry")
    @review_1 = @book_1.reviews.create!(title: "Review_1", rating: 3, text: "Review 1 description")
    @review_2 = @book_1.reviews.create!(title: "Review_2", rating: 2, text: "Review 2 description")
    @review_3 = @book_1.reviews.create!(title: "Review_3", rating: 4, text: "Review 3 description")
    @user_1.reviews << @review_1
    @user_1.reviews << @review_2
    @user_1.reviews << @review_3
  end

  it 'Show page shows book and info' do
    visit book_path(@book_1)

    within "#book-id-#{@book_1.id}" do
      expect(page).to have_xpath('//img[@src="google.com"]')
      expect(page).to have_content('Title: Book_1')
      expect(page).to have_content('Pages: 300')
      expect(page).to have_content('Year Published: 1999')
    end

    visit book_path(@book_2)

    within "#book-id-#{@book_2.id}" do
      expect(page).to have_xpath('//img[@src="google.com"]')
      expect(page).to have_content('Title: Book_2')
      expect(page).to have_content('Pages: 300')
      expect(page).to have_content('Year Published: 1999')
    end

    visit book_path(@book_3)

    within "#book-id-#{@book_3.id}" do
      expect(page).to have_xpath('//img[@src="google.com"]')
      expect(page).to have_content('Title: Book_3')
      expect(page).to have_content('Pages: 300')
      expect(page).to have_content('Year Published: 1999')
    end
  end

  it 'Shows a section where reviews for the book are shown' do

    visit book_path(@book_1)

    within "#review-id-#{@review_1.id}" do
      expect(page).to have_content('Title: Review_1')
      expect(page).to have_content('User: Henry')
      expect(page).to have_content('Rating: 3')
      expect(page).to have_content('Contents: Review 1 description')
    end

    within "#review-id-#{@review_2.id}" do
      expect(page).to have_content('Title: Review_2')
      expect(page).to have_content('User: Henry')
      expect(page).to have_content('Rating: 2')
      expect(page).to have_content('Contents: Review 2 description')
    end

    within "#review-id-#{@review_3.id}" do
      expect(page).to have_content('Title: Review_3')
      expect(page).to have_content('User: Henry')
      expect(page).to have_content('Rating: 4')
      expect(page).to have_content('Contents: Review 3 description')
    end
  end

  it "Index page Authors links to author show page" do
    visit books_path(@book_1)

    expect(page).to have_link(@book_1.title)

    click_link @book_1.title

    expect(current_path).to eq(book_path(@book_1))
    expect(page).to have_content(@author_1.name)
  end
end
