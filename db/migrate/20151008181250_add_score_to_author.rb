class AddScoreToAuthor < ActiveRecord::Migration
  def change
    add_column :authors, :score, :float
    add_column :leaders, :score, :float
  end
end
