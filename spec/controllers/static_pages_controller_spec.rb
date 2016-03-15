require "rails_helper"

RSpec.describe StaticPagesController do

  describe "GET home" do
    it "gets home" do
      get :home
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET about" do
    it "gets about" do
      get :about
      expect(response).to have_http_status(:ok)
    end
  end

end
