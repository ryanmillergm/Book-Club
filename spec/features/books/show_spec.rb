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
    @review_1 = @book_1.reviews.create!(title: "Review_1", rating: 5, text: "Review 1 description")
    @review_2 = @book_1.reviews.create!(title: "Review_2", rating: 4, text: "Review 2 description")
    @review_3 = @book_1.reviews.create!(title: "Review_3", rating: 3, text: "Review 3 description")
    @review_4 = @book_1.reviews.create!(title: "Review_4", rating: 2, text: "Review 1 description")
    @review_5 = @book_1.reviews.create!(title: "Review_5", rating: 1, text: "Review 2 description")
    @user_1.reviews << @review_1
    @user_1.reviews << @review_2
    @user_1.reviews << @review_3
    @user_1.reviews << @review_4
    @user_1.reviews << @review_5
  end

  it 'Show page shows book and info' do
    visit book_path(@book_1)

    within "#book-id-#{@book_1.id}" do
      expect(page).to have_xpath('//img[@src="google.com"]')
      expect(page).to have_content("Title: Book 1")
      expect(page).to have_content('Pages: 300')
      expect(page).to have_content('Year Published: 1999')
    end

    visit book_path(@book_2)

    within "#book-id-#{@book_2.id}" do
      expect(page).to have_xpath('//img[@src="google.com"]')
      expect(page).to have_content("Title: Book 2")
      expect(page).to have_content('Pages: 300')
      expect(page).to have_content('Year Published: 1999')
    end

    visit book_path(@book_3)

    within "#book-id-#{@book_3.id}" do
      expect(page).to have_xpath('//img[@src="google.com"]')
      expect(page).to have_content("Title: Book 3")
      expect(page).to have_content('Pages: 300')
      expect(page).to have_content('Year Published: 1999')
    end
  end

  it 'Shows a section where reviews for the book are shown' do

    visit book_path(@book_1)

    within "#review-id-#{@review_1.id}" do
      expect(page).to have_content('Title: Review_1')
      expect(page).to have_content('User: Henry')
      expect(page).to have_content('Rating: 5')
      expect(page).to have_content('Contents: Review 1 description')
    end

    within "#review-id-#{@review_2.id}" do
      expect(page).to have_content('Title: Review_2')
      expect(page).to have_content('User: Henry')
      expect(page).to have_content('Rating: 4')
      expect(page).to have_content('Contents: Review 2 description')
    end

    within "#review-id-#{@review_3.id}" do
      expect(page).to have_content('Title: Review_3')
      expect(page).to have_content('User: Henry')
      expect(page).to have_content('Rating: 3')
      expect(page).to have_content('Contents: Review 3 description')
    end
  end

  it "Index page Authors links to author show page" do
    visit books_path(@book_1)

    expect(page).to have_link(@book_1.title)

    within "#book-id-#{@book_1.id}" do
      click_link @book_1.title
    end

    expect(current_path).to eq(book_path(@book_1))
    expect(page).to have_content(@author_1.name)
  end

  it "Sorts by top three reviews" do
    visit book_path(@book_1)

    within ".top_three_reviews" do
      expect(page.all('p')[0]).to have_content("Title: #{@review_1.title}")
      expect(page.all('p')[1]).to have_content("Rating: #{@review_1.rating}")
      expect(page.all('p')[2]).to have_content("User: #{@review_1.user.name}")
      expect(page.all('p')[3]).to have_content("Title: #{@review_2.title}")
      expect(page.all('p')[4]).to have_content("Rating: #{@review_2.rating}")
      expect(page.all('p')[5]).to have_content("User: #{@review_2.user.name}")
      expect(page.all('p')[6]).to have_content("Title: #{@review_3.title}")
      expect(page.all('p')[7]).to have_content("Rating: #{@review_3.rating}")
      expect(page.all('p')[8]).to have_content("User: #{@review_3.user.name}")
    end
  end

  it "Sorts by bottom three reviews" do
    visit book_path(@book_1)

    within ".bottom_three_reviews" do
      expect(page.all('p')[0]).to have_content("Title: #{@review_5.title}")
      expect(page.all('p')[1]).to have_content("Rating: #{@review_5.rating}")
      expect(page.all('p')[2]).to have_content("User: #{@review_5.user.name}")
      expect(page.all('p')[3]).to have_content("Title: #{@review_4.title}")
      expect(page.all('p')[4]).to have_content("Rating: #{@review_4.rating}")
      expect(page.all('p')[5]).to have_content("User: #{@review_4.user.name}")
      expect(page.all('p')[6]).to have_content("Title: #{@review_3.title}")
      expect(page.all('p')[7]).to have_content("Rating: #{@review_3.rating}")
      expect(page.all('p')[8]).to have_content("User: #{@review_3.user.name}")
    end
  end

  it "Sorts by overall average rating" do
    visit book_path(@book_1)

    within ".overall_average_rating" do
      expect(page).to have_content("Overall Average Rating: 3")
    end
  end
end

#
# As a Visitor,
# When I visit a book's show page,
# I see an area on the page for statistics about reviews:
# - the top three reviews for this book (title, rating and user only)
# - the bottom three reviews for this book  (title, rating and user only)
# - the overall average rating of all reviews for this book
