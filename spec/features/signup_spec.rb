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

  it "displays an error when the name is missing" do
    visit "/signup"

    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz"
    click_button "Create account"

    expect(current_path).to include("A name is required")
  end

  it "displays an error when the name is too long" do
    visit "/signup"

    fill_in "Name", with: "c" * 33
    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz"
    click_button "Create account"

    expect(current_path).to include("The name is too long")
  end

  it "displays an error when the email is missing" do
    visit "/signup"

    fill_in "Name", with: "chuckeles"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz"
    click_button "Create account"

    expect(current_path).to include("A valid email is required")
  end

  it "displays an error when the email is wrong" do
    visit "/signup"

    fill_in "Name", with: "chuckeles"
    fill_in "Email", with: "me@me"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz"
    click_button "Create account"

    expect(current_path).to include("A valid email is required")
  end

  it "displays an error when the password is missing" do
    visit "/signup"

    fill_in "Name", with: "chuckeles"
    fill_in "Email", with: "me@chuckeles.me"
    click_button "Create account"

    expect(page).to include("A password is required")
  end

  it "displays an error when the passwords do not match" do
    visit "/signup"

    fill_in "Name", with: "chuckeles"
    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz2"
    click_button "Create account"

    expect(page).to include("The passwords do not match")
  end

  it "displays an error when the password is too short" do
    visit "/signup"

    fill_in "Name", with: "chuckeles"
    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foo"
    fill_in "Confirm password", with: "foo"
    click_button "Create account"

    expect(page).to include("The password must be at least 6 characters long")
  end

end
