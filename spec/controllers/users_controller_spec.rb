RSpec.describe UsersController do

  describe "GET show" do
    before do
      @user = User.create(name: "chuckeles", email: "me@chuckeles.me", password: "foobaz", password_confirmation: "foobaz")
    end

    it "gets show" do
      get :show, { id: @user.id }

      expect(response).to have_http_status(:ok)
    end

    it "has show template" do
      get :show, { id: @user.id }

      expect(response).to render_template(:show)
    end
  end

  describe "GET new" do
    it "gets new" do
      get :new

      expect(response).to have_http_status(:ok)
    end

    it "has new template" do
      get :new

      expect(response).to render_template(:new)
    end
  end

end
