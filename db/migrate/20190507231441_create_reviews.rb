class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :username
      t.integer :rating
      t.string :text
    end
  end
end
