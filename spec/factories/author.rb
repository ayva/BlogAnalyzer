FactoryGirl.define do
  factory :author do
    blog_url "URL"
    full_name "Name"
    author_pic "PIC url"
    created_at "2015-10-07 16:23:20"
    updated_at "2015-10-07 16:23:20"
    username "Nickname"
    score "99.8"

  end

  # factory :leader do
  #   category "Style"
  #   score "99.8"
  #   created_at "2015-10-07 16:23:20"
  #   updated_at "2015-10-07 16:23:20"
  #   author
  # end

end