require 'rails_helper'

RSpec.describe LandingPagesController, type: :controller do
  describe "GET main" do
    it "has a 200 status code" do
      get :main
      expect(response.status).to eq(200)
    end
  end

end
