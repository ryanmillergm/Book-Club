class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :pages
      t.integer :year_published
      t.string :book_img_url

      t.timestamps
    end
  end
end
