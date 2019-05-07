require 'rails_helper'
require 'pry'

RSpec.describe 'Nav bar test', type: :feature do

  it 'Nav Bar Should link to home page' do
    visit books_path

    within '.top-nav' do
      click_link('Home')

      expect(current_path).to eq(root_path)
    end
  end


  it 'Nav Bar Should link to books index page' do

    visit root_path

    within '.top-nav' do
      click_link('Books')

      expect(current_path).to eq(books_path)
    end
  end
end
