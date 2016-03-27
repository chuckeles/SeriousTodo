RSpec.describe "Main menu" do

  before do
    @user = User.create(name: "chuckeles", email: "me@chuckeles.me", password: "foobaz", password_confirmation: "foobaz")
  end

  let :login do
    visit login_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Login"
  end

  it "has a link to about" do
    visit root_path

    click_link "About"

    expect(page).to have_current_path(about_path)
  end

  it "has a link to login" do
    visit root_path

    click_link "Login"

    expect(page).to have_current_path(login_path)
  end

  it "has a link to signup" do
    visit root_path

    click_link "Sign up"

    expect(page).to have_current_path(new_user_path)
  end

  it "has profile and logout links and does not have signup and login links when a user is logged in" do
    login
    visit root_path

    expect(page).to have_content("Profile")
    expect(page).to have_content("Logout")
    expect(page).to_not have_content("Signup")
    expect(page).to_not have_content("Login")
  end


  it "has a link to logged user's profile" do
    login
    visit root_path

    click_link "Profile"

    expect(page).to have_current_path(user_path(@user))
  end

  it "has a logout link that logs the user out" do
    login
    visit root_path

    click_link "Logout"

    expect(page).to have_content("Login")
    expect(page).to_not have_content("Logout")
  end

end
