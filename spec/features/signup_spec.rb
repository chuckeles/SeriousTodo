RSpec.describe "Signup page" do

  it "creates new user when all required fields are filled" do
    visit "/signup"

    fill_in "Name", with: "chuckeles"
    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz"
    click_button "Create account"

    expect(page).to include("Success!")
  end

  it "does not create a user when the name is missing" do
    visit "/signup"

    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz"
    click_button "Create account"

    expect(current_path).to eq("/signup")
  end

  it "does not create a user when the email is missing" do
    visit "/signup"

    fill_in "Name", with: "chuckeles"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz"
    click_button "Create account"

    expect(current_path).to eq("/signup")
  end

  it "does not create a user when the email is wrong" do
    visit "/signup"

    fill_in "Name", with: "chuckeles"
    fill_in "Email", with: "me@me"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz"
    click_button "Create account"

    expect(current_path).to eq("/signup")
  end

end
