RSpec.describe "Homepage menu" do

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

end
