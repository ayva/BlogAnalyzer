class AddUserIdToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :user_id, :integer
    add_index :accounts, :provider
    add_index :accounts, :uid
    add_index :accounts, [:provider, :uid], unique: true
  end
end
