require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'Relationship' do
    it { should have_many :books }
    it { should have_many(:books).through(:author_books) }
  end
end
