class AddFacebookTwitterAuthot < ActiveRecord::Migration
  def change
    add_column :authors, :twitter, :string
    add_column :authors, :facebook, :string
  end
end
