RSpec.describe "Login" do

  context "when the credentials are correct" do
    it "creates new session" do
      fill_in_user_details
      click_button "Log in"

      expect(page).to have_content("Profile")
    end
  end

  context "when the credentials are wrong" do
    it "displays an error" do
      click_button "Log in"

      expect(page).to have_css(".flashes.alert")
    end

    it "hides the error message after another request" do
      click_button "Log in"
      visit new_user_session_path

      expect(page).to_not have_css(".flashes.alert")
    end
  end

  before do
    visit new_user_session_path
  end

  let(:user) do
    user = User.new(
      name: "chuckeles",
      email: "me@chuckeles.me",
      password: "foobaaaz123",
      password_confirmation: "foobaaaz123"
    )
    user.skip_confirmation!
    user.save!
    user
  end

  def fill_in_user_details
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
  end

  def fill_in_some_details
    fill_in "Email", with: "yo@chuckeles.me"
    fill_in "Password", with: "foobaaz123"
  end

end
