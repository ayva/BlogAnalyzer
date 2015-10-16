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
  end

  context "error rates" do
    let(:author) { create(:author) }
    let(:post) { create(:post, author: author) }

    context "style errors" do

      it 'should properly count style errors' do

        post.hints.create(title: "a", group_id: 1)
        post.hints.create(title: "a", group_id: 1)
        post.hints.create(title: "a", group_id: 1)
        post.hints.create(title: "a", group_id: 1)

        expect(author.style_errors).to eq(4)
      end

      it 'should properly get style error rate' do
        post.hints.create(title: "a", group_id: 1)
        post.hints.create(title: "a", group_id: 1)
        post.hints.create(title: "a", group_id: 1)
        post.hints.create(title: "a", group_id: 1)

        expect(author.style_error_rate).to eq(0.53)
      end
    end

      context "punctuation errors" do

      it 'should properly count punctuation errors' do

        post.hints.create(title: "a", group_id: 2)
        post.hints.create(title: "a", group_id: 2)
        post.hints.create(title: "a", group_id: 2)

        expect(author.punctuation_errors).to eq(3)
      end

      it 'should properly get punctuation error rate' do
        post.hints.create(title: "a", group_id: 2)
        post.hints.create(title: "a", group_id: 2)
        post.hints.create(title: "a", group_id: 2)

        expect(author.punctuation_error_rate).to eq(0.4)
      end
    end
  end


end
