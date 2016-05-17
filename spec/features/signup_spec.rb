RSpec.describe "Signup" do

  context "when all required fields are filled" do
    it "creates a user" do
      fill_in_user_details

      expect { click_button "Sign up" }.to change{ User.count }.by(1)
    end

    it "sends a confirmation email" do
      fill_in_user_details

      click_button "Sign up"
      expect(page).to have_content("confirmation link has been sent to your email")
    end
  end

  context "when the form is not correct" do
    it "displays an error" do
      click_button "Sign up"

      expect(page).to have_css(".flashes.danger")
    end
  end

  before do
    visit new_user_registration_path
  end

  def fill_in_user_details
    fill_in "Name", with: "chuckeles"
    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foobaaaz123"
    fill_in "Confirm password", with: "foobaaaz123"
  end

end
