RSpec.describe "Login" do

  it "creates new session when the credentials are correct" do
    user = User.create(name: "chuckeles", email: "me@chuckeles.me", password: "foobaaaz", password_confirmation: "foobaaaz")
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    visit root_path
    expect(page).to have_content("Log out")
  end

  it "displays an error when the credentials are wrong" do
    visit new_user_session_path

    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foobaaz"
    click_button "Log in"

    expect(page).to have_content("Invalid")
  end

  it "hides the error message after another request" do
    visit new_user_session_path

    click_button "Log in"
    visit new_user_session_path

    expect(page).to_not have_content("Invalid")
  end

end
