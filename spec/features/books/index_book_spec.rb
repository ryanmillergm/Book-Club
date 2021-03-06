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
    @review_12 = @book_4.reviews.create(title: 'title_11', rating: 1, text: 'body_11')
    @review_12 = @book_1.reviews.create(title: 'title_11', rating: 1, text: 'body_11')

    @user_1.reviews = [@review_1, @review_2, @review_5, @review_6, @review_12]
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
      expect(page).to have_content('Author(s): Bill')
      expect(page).to have_content("Average Rating: #{@book_1.average_rating}")
      expect(page).to have_content("Review Count: #{@book_1.reviews.count}")


    end

    within "#book-id-#{@book_2.id}" do
      expect(page).to have_xpath('//img[@src="google.com"]')
      expect(page).to have_content('Title: Book 2')
      expect(page).to have_content('Pages: 302')
      expect(page).to have_content('Year Published: 1999')
      expect(page).to have_content('Author(s): Jerry')
      expect(page).to have_content("Average Rating: #{@book_2.average_rating}")
      expect(page).to have_content("Review Count: #{@book_2.reviews.count}")
    end

    within "#book-id-#{@book_3.id}" do
      expect(page).to have_xpath('//img[@src="google.com"]')
      expect(page).to have_content('Title: Book 3')
      expect(page).to have_content('Pages: 350')
      expect(page).to have_content('Year Published: 1999')
      expect(page).to have_content('Author(s): Tom')
      expect(page).to have_content("Average Rating: #{@book_3.average_rating}")
      expect(page).to have_content("Review Count: #{@book_3.reviews.count}")
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

  it "books to sort by page by ascending" do
    visit books_path

    click_on 'Sort By Least Pages'
    within ".book-ctn" do
      # binding.pry
      expect(page.all('h2')[0]).to have_content(@book_4.title)
      expect(page.all('h2')[1]).to have_content(@book_2.title)
      expect(page.all('h2')[2]).to have_content(@book_1.title)
      expect(page.all('h2')[3]).to have_content(@book_3.title)
    end
  end

  it "books to sort by pages by descending" do
    visit books_path

    click_on 'Sort By Most Pages'
    within ".book-ctn" do
      # binding.pry
      expect(page.all('h2')[0]).to have_content(@book_3.title)
      expect(page.all('h2')[1]).to have_content(@book_1.title)
      expect(page.all('h2')[2]).to have_content(@book_2.title)
      expect(page.all('h2')[3]).to have_content(@book_4.title)
    end
  end

  it "books to sort by most reviews" do
    visit books_path

    click_on 'Sort By Most Reviews'
    within ".book-ctn" do
      expect(page.all('h2')[0]).to have_content("Title: #{@book_1.title}")
      expect(page.all('h2')[1]).to have_content("Title: #{@book_2.title}")
      expect(page.all('h2')[2]).to have_content("Title: #{@book_4.title}")
      expect(page.all('h2')[3]).to have_content("Title: #{@book_3.title}")
    end
  end

  it "books to sort by least reviews" do
    visit books_path

    click_on 'Sort By Least Reviews'
    within ".book-ctn" do
      expect(page.all('h2')[0]).to have_content("Title: #{@book_3.title}")
      expect(page.all('h2')[1]).to have_content("Title: #{@book_4.title}")
      expect(page.all('h2')[2]).to have_content("Title: #{@book_2.title}")
      expect(page.all('h2')[3]).to have_content("Title: #{@book_1.title}")
    end
  end

    it "books to sort by Best Ratings" do
      visit books_path

      click_on 'Sort By Best Ratings'
      within ".book-ctn" do
        expect(page.all('h2')[0]).to have_content("Title: #{@book_3.title}")
        expect(page.all('h2')[1]).to have_content("Title: #{@book_2.title}")
        expect(page.all('h2')[2]).to have_content("Title: #{@book_1.title}")
        expect(page.all('h2')[3]).to have_content("Title: #{@book_4.title}")
      end
    end

    it "books to sort by Worst Ratings" do
      visit books_path

      click_on 'Sort By Worst Ratings'
      within ".book-ctn" do
        expect(page.all('h2')[0]).to have_content("Title: #{@book_4.title}")
        expect(page.all('h2')[1]).to have_content("Title: #{@book_1.title}")
        expect(page.all('h2')[2]).to have_content("Title: #{@book_2.title}")
        expect(page.all('h2')[3]).to have_content("Title: #{@book_3.title}")
      end
    end

  it "Index page shows statistics area" do

    visit books_path


    within ".statistics-area" do
      within "#highest-rated-books" do
        expect(page.all('h3')[0]).to have_content("Title: #{@book_3.title}")
        expect(page.all('h3')[1]).to have_content("Title: #{@book_2.title}")
        expect(page.all('h3')[2]).to have_content("Title: #{@book_1.title}")
      end

      within "#lowest-rated-books" do
        expect(page.all('h3')[0]).to have_content("Title: #{@book_4.title}")
        expect(page.all('h3')[1]).to have_content("Title: #{@book_1.title}")
        expect(page.all('h3')[2]).to have_content("Title: #{@book_2.title}")
      end

      within "#users-with-most-reviews" do
        expect(page.all('h3')[0]).to have_content("User: #{@user_1.name}")
        expect(page.all('h3')[1]).to have_content("User: #{@user_2.name}")
        expect(page.all('h3')[2]).to have_content("User: #{@user_3.name}")
      end
    end
  end
end
