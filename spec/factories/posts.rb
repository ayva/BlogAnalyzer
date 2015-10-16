FactoryGirl.define do
  factory :post do
    author
    sequence(:post_url) {|n| n }
    word_count 750
  end
end
