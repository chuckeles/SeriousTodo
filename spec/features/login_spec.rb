RSpec.describe "Login" do


  it "creates new session when the credentials are correct" do
    User.create(name: "chuckeles", email: "me@chuckeles.me", password: "foobaz", password_confirmation: "foobaz")
    visit login_path

    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foobaz"
    click_button "Login"

    expect(page).to have_content("chuckeles")
  end

  it "displays an error when the email is missing" do
    visit login_path

    fill_in "Password", with: "foobaz"
    click_button "Login"

    expect(page).to have_content("Invalid email and password combination")
  end

  it "displays an error when the password is missing" do
    visit login_path

    fill_in "Email", with: "me@chuckeles.me"
    click_button "Login"

    expect(page).to have_content("Invalid email and password combination")
  end

  it "displays an error when the credentials are wrong" do
    visit login_path

    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foobaaz"
    click_button "Login"

    expect(page).to have_content("Invalid email and password combination")
  end

  it "hides the error message after another request" do
    visit login_path

    click_button "Login"

    expect(page).to have_content("Invalid email and password combination")

    visit login_path

    expect(page).to_not have_content("Invalid email and password combination")
  end

end
