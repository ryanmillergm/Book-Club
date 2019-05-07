require 'rails_helper'
require 'pry'

RSpec.describe 'Nav bar test', type: :feature do


  it 'Nav Bar Should link to a index page' do

    visit '/'
    save_and_open_page

    within '.top-nav' do
      click_link('Books')

      expect(current_path).to eq(books_path)
    end
  end
end
