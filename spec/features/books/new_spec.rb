require 'rails_helper'

RSpec.describe 'book new page', type: :feature do
  it 'book new page can create new book' do
    visit books_path

    within ".new-book-link" do
      click_link("Add a new Book")
    end

    expect(current_path).to eq(new_book_path)

    fill_in 'Title', with: 'Great Expectations'
    fill_in 'Pages', with: 125
    fill_in 'Year published', with: 1945
    fill_in 'Book img url', with: 'google.com'
    fill_in 'Author', with: 'Ryan Miller, Blake'


    click_on 'Create Book'

    new_book = Book.last

    expect(current_path).to eq(books_path)
    expect(page).to have_content(new_book.title)
    expect(page).to have_content(new_book.pages)
    expect(page).to have_xpath('//img[@src="google.com"]')
    expect(page).to have_content(new_book.year_published)
  end

  it 'Can leave image blank' do
    visit new_book_path

    fill_in 'Title', with: 'Great Expectations'
    fill_in 'Pages', with: 125
    fill_in 'Year published', with: 1945
    fill_in 'Book img url', with: ''
    fill_in 'Author', with: 'Ryan Miller, Blake'

    click_on 'Create Book'

    new_book = Book.last

    expect(page).to_not have_xpath('//img[@src="google.com"]')

  end


end
#
# The form includes the following items:
#
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
