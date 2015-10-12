class Hint < ActiveRecord::Base
  has_many :posthints
  has_many :posts, through: :posthints
  has_many :authors, through: :posts

  belongs_to :group
  
end
