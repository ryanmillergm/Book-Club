require 'rails_helper'

RSpec.describe 'book new page', type: :feature do
  it 'book new page can create new book' do
    visit new_book_path

    fill_in 'title', with: 'Great Expectations'
    fill_in 'pages', with: 125
    fill_in 'year_published', with: 1945
    fill_in 'book_img_url', with: 'google.com'

    click_on 'Create book'

    new_book = Book.last

    expect(current_path).to eq(books_path)
    expect(page).to have_content(new_book.title)
    expect(page).to have_content(new_book.pages)
    expect(page).to have_content(new_book.year_published)
  end
end


# As a Visitor,
# When I visit the book index page,
# I see a link that allows me to add a new book.
# When I click that link, I am taken to a new book path.
# I can fill in a form to add a new book.
# The form includes the following items:
# - title
# - year book was published
# - number of pages (0 or higher)
# - image of the book cover (optional, can be left blank)
# - a list of authors (see notes below)
#
# When I submit the form, I am taken to that book's show page.
#
# Book titles should be converted to Title Case before saving.
# Book titles should be unique within the system.
# For authors, a comma-separated list of names should be entered,
# and each author will be added to the database.
# Authors added to the database should have their names converted
# to Title Case.
# Author Names should be unique within the system.
# If image field is left blank, a default image should be set.
