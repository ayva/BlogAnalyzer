class Posthint < ActiveRecord::Base
  belongs_to :hint
  belongs_to :post
end
