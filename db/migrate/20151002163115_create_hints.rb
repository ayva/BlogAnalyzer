class CreateHints < ActiveRecord::Migration
  def change
    create_table :hints do |t|
      t.string :title, null: false
      t.references :group, null: false
      t.timestamps null: false
    end
  end
end
