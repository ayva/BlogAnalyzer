class AddUserNameToAuthorModel < ActiveRecord::Migration
  def change
    remove_column :authors, :nickname
    add_column :authors, :username, :string
  end
end
