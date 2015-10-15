require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  it "creates new author" do
    expect{
      post :newblogger, format: :json, author: attributes_for(:author)}.to change(Delayed::Job , :count).by(1)
  end

  it "doesn't create new author if it exists" do
    create(:author)
    expect{
      post :newblogger, format: :json, author: attributes_for(:author)}.to change(Author , :count).by(0)
  end

  it "has index action" do
    get :index, format: :json
    expect(response).to_not render_template :index
  end

  describe "Author API" do
    it "renders show template" do
      author = create(:author)
         
      get :show, format: :json, :id => author.id
      
      
      expect(response).to be_success
      expect(response).to render_template(:show)
      
    end

    it "returns leaderboards" do
      get :leaderboards, format: :json
      
      expect(response).to be_success
      expect(JSON.parse(response.body).length).to eq(2)
    end

    it "returns leaders in grouptop" do
      create(:leader)
      get :grouptop, format: :json
      expect(response).to be_success
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end
end
