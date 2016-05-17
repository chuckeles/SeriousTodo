RSpec.describe "Profile" do

  context "when logged in" do
    it "should be editable" do
      log_in_as_user

      visit user_path(user)
      click_link "Edit"

      fill_in_new_user_details
      click_button "Save"

      expect(User.find(user.id).name).to eq("yochuckeles")
    end
  end

  context "when not logged in" do
    it "should not be editable" do
      visit user_path(user)

      expect(page).to_not have_button("Edit")
    end
  end

  let(:user) do
    user = User.new(
      name: "chuckeles",
      email: "me@me.me",
      password: "foobaaaz123",
      password_confirmation: "foobaaaz123"
    )
    user.skip_confirmation!
    user.save!
    user
  end

  def log_in_as_user
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"
  end

  def fill_in_new_user_details
    fill_in "Name", with: "yochuckeles"
    fill_in "Current password", with: user.password
  end

end
