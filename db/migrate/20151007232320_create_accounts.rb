class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      # t.references :user, index: true, foreign_key: true
      t.string :uid, null: false
      t.string :provider, null: false
      t.string :username
      t.string :oauth_token
      t.string :oauth_secret
      t.datetime :oauth_expires

      t.timestamps null: false
    end
  end
end
