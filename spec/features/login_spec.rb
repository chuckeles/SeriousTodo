RSpec.describe "Login" do

  it "creates new session when the credentials are correct" do
    user = User.create(name: "chuckeles", email: "me@chuckeles.me", password: "foobaz", password_confirmation: "foobaz")
    visit login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Login"

    expect(page).to have_content("chuckeles")
  end

  it "displays an error when the credentials are wrong" do
    visit login_path

    fill_in "Email", with: "me@chuckeles.me"
    fill_in "Password", with: "foobaaz"
    click_button "Login"

    expect(page).to have_content("Invalid")
  end

  it "hides the error message after another request" do
    visit login_path

    click_button "Login"
    visit login_path

    expect(page).to_not have_content("Invalid")
  end

end
