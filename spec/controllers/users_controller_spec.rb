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

    # TODO: test if it shows correct user
  end

end
