require 'rails_helper'

RSpec.describe AuthorBooks, type: :model do
  describe 'Relationship' do
    it { should belong_to :author }
    it { should belong_to :book }
  end

end
