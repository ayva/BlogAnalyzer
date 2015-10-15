require 'rails_helper'

RSpec.describe Author, type: :model do
  let (:author) do
    Author.create(  :blog_url => "URL",
                    :full_name => "Name",
                    :author_pic => "PIC url",
                    :created_at => "2015-10-07 16:23:20",
                    :updated_at => "2015-10-07 16:23:20",
                    :username => "Nickname",
                    :score => "99.8") 
  end
  context "author attributes" do
    it "has a score" do
      expect(author.score).to eq(99.8)
    end

    it "has username composed of full name" do
      
    end
  end

  
end