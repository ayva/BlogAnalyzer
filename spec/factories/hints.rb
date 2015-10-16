FactoryGirl.define do
  factory :hint do
    post
    title "My hint"
    sequence(:group_id) {|n| n % 7}
  end
end
