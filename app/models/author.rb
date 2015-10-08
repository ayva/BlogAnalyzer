class Author < ActiveRecord::Base
  has_many :posts
  has_many :hints, through: :posts


end
