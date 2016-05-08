RSpec.describe "Signup" do

  before do
    visit new_user_registration_path
  end

  context "when all required fields are filled" do
    it "creates a user" do
      fill_in "Name", with: "chuckeles"
      fill_in "Email", with: "me@chuckeles.me"
      fill_in "Password", with: "foobaaaz123"
      fill_in "Confirm password", with: "foobaaaz123"

      expect { click_button "Sign up" }.to change{ User.count }.by(1)
    end
  end

  context "when the form is not correct" do
    it "displays an error" do
      click_button "Sign up"

      expect(page).to have_css(".flashes.danger")
    end
  end

end
