class CreateLeaders < ActiveRecord::Migration
  def change
    create_table :leaders do |t|
      t.string :category
      t.integer :author_id

      t.timestamps null: false
    end
  end
end
