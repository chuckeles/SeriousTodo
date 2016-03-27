RSpec.describe SessionsController do

  describe "GET new" do
    it "returns http success" do
      get :new

      expect(response).to have_http_status(:success)
    end

    it "renders new template" do
      get :new

      expect(response).to render_template(:new)
    end
  end

end
