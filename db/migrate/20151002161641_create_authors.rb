class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :blog_url, null: false
      t.string :full_name, null: false
      t.string :nickname, null: false
      t.string :author_pic, null: false
      t.timestamps null: false
    end
  end
end
