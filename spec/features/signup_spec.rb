RSpec.describe "Signup page" do

  it "creates new user when all required fields are filled" do
    visit "/signup"

    fill_in "Name", with: "chuckeles"
    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz"
    click_button "Create account"

    expect(page).to have_content("chuckeles")
    expect(page).to have_content("me@chuckeles.me")
  end

  it "displays an error when the name is missing" do
    visit "/signup"

    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz"
    click_button "Create account"

    expect(page).to have_content("Name can't be blank")
  end

  it "displays an error when the name is too long" do
    visit "/signup"

    fill_in "Name", with: "c" * 33
    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz"
    click_button "Create account"

    expect(page).to have_content("Name is too long")
  end

  it "displays an error when the name is already taken" do
    User.create(name: "chuckeles", email: "me@chuckeles.me", password: "foobaz", password_confirmation: "foobaz")
    visit "/signup"

    fill_in "Name", with: "chuckeles"
    fill_in "Email", with: "me2@chuckeles.me"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz"
    click_button "Create account"

    expect(page).to have_content("Name has already been taken")
  end

  it "displays an error when the email is missing" do
    visit "/signup"

    fill_in "Name", with: "chuckeles"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz"
    click_button "Create account"

    expect(page).to have_content("Email can't be blank")
  end

  it "displays an error when the email is wrong" do
    visit "/signup"

    fill_in "Name", with: "chuckeles"
    fill_in "Email", with: "me@me"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz"
    click_button "Create account"

    expect(page).to have_content("Email is invalid")
  end

  it "displays an error when the email is already taken" do
    User.create(name: "chuckeles", email: "me@chuckeles.me", password: "foobaz", password_confirmation: "foobaz")
    visit "/signup"

    fill_in "Name", with: "chuckeles2"
    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz"
    click_button "Create account"

    expect(page).to have_content("Email has already been taken")
  end

  it "displays an error when the password is missing" do
    visit "/signup"

    fill_in "Name", with: "chuckeles"
    fill_in "Email", with: "me@chuckeles.me"
    click_button "Create account"

    expect(page).to have_content("Password can't be blank")
  end

  it "displays an error when the passwords do not match" do
    visit "/signup"

    fill_in "Name", with: "chuckeles"
    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foobaz"
    fill_in "Confirm password", with: "foobaz2"
    click_button "Create account"

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  it "displays an error when the password is too short" do
    visit "/signup"

    fill_in "Name", with: "chuckeles"
    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foo"
    fill_in "Confirm password", with: "foo"
    click_button "Create account"

    expect(page).to have_content("Password is too short")
  end

end
