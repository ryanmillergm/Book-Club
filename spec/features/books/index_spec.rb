require 'rails_helper'

RSpec.describe 'book index page', type: :feature do
  before :each do
    @book_1 = Book.create!(title: "Book_1", pages: 307, year_published: 1999, book_img_url: "google.com")
    @book_2 = Book.create!(title: "Book_2", pages: 302, year_published: 1999, book_img_url: "google.com")
    @book_3 = Book.create!(title: "Book_3", pages: 350, year_published: 1999, book_img_url: "google.com")
    @author_1 = Author.create!(name: "Bill")
    @author_2 = Author.create!(name: "Jerry")
    @author_3 = Author.create!(name: "Tom")
    @author_1.books << @book_1
    @author_2.books << @book_2
    @author_3.books << @book_3
  end

  it 'Index page shows a list of books' do
    visit '/books'

    within "#book-id-#{@book_1.id}" do
      expect(page).to have_xpath('//img[@src="google.com"]')
      expect(page).to have_content('Title: Book 1')
      expect(page).to have_content('Pages: 300')
      expect(page).to have_content('Year Published: 1999')
      expect(page).to have_content('Author(s): Bill')

    end

    within "#book-id-#{@book_2.id}" do
      expect(page).to have_xpath('//img[@src="google.com"]')
      expect(page).to have_content('Title: Book 2')
      expect(page).to have_content('Pages: 300')
      expect(page).to have_content('Year Published: 1999')
      expect(page).to have_content('Author(s): Jerry')
    end

    within "#book-id-#{@book_3.id}" do
      expect(page).to have_xpath('//img[@src="google.com"]')
      expect(page).to have_content('Title: Book 3')
      expect(page).to have_content('Pages: 300')
      expect(page).to have_content('Year Published: 1999')
      expect(page).to have_content('Author(s): Tom')
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

  it "books to sort by page" do
    click_on 'sort'

    expect(page.all(".book-ctn")).to have_content(@book_2.title)
    expect(page.all(".book-ctn")).to have_content(@book_1.title)
    expect(page.all(".book-ctn")).to have_content(@book_3.title)
  end

end 
