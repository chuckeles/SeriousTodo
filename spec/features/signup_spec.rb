RSpec.describe "Signup" do

  it "creates new user when all required fields are filled" do
    visit new_user_registration_path

    fill_in "Name", with: "chuckeles"
    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foobaaaz"
    fill_in "Confirm password", with: "foobaaaz"
    click_button "Sign up"

    expect(User.count).to eq(1)
  end

end
