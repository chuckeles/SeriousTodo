RSpec.describe "Signup" do

  it "creates new user when all required fields are filled" do
    visit new_user_path

    fill_in "Name", with: "chuckeles"
    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz"
    click_button "Create account"

    expect(page).to have_content("chuckeles")
    expect(page).to have_content("me@chuckeles.me")
  end

end
