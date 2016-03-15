require "rails_helper"

RSpec.describe StaticPagesController do

  describe "GET home" do
    it "gets home" do
      get :home
      expect(response).to have_http_status(:ok)
    end

    it "has home template" do
      get :home
      expect(response).to render_template(:home)
    end
  end

  describe "GET about" do
    it "gets about" do
      get :about
      expect(response).to have_http_status(:ok)
    end

    it "has about template" do
      get :about
      expect(response).to render_template(:about)
    end
  end

end
