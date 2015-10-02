class CreatePosthints < ActiveRecord::Migration
  def change
    create_table :posthints do |t|
      t.references :post, null: false
      t.references :hint, null: false
      t.timestamps null: false
    end
  end
end
