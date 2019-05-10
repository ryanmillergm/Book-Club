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

    expect(current_path).to eq(book_path(new_book))
    expect(page).to have_content(new_book.title)
    expect(page).to have_content(new_book.pages)
    expect(page).to have_xpath('//img[@src="google.com"]')
    expect(page).to have_content(new_book.year_published)
  end

  it 'Can leave image blank' do
    visit new_book_path

    fill_in 'Title', with: 'great expectations'
    fill_in 'Pages', with: 125
    fill_in 'Year published', with: 1945
    fill_in 'Book img url', with: ''
    fill_in 'Author', with: 'ryan miller, blake'

    click_on 'Create Book'

    new_book = Book.last

    expect(page).to have_content('Title: Great Expectations')
    expect(page).to have_xpath('//img[@src="https://ibf.org/site_assets/img/placeholder-book-cover-default.png"]')
    expect(new_book.authors[0].name).to eq('Ryan Miller')
    expect(new_book.authors[1].name).to eq('Blake')
  end


end
