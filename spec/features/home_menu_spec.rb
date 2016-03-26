RSpec.describe "Homepage menu" do

  it "has a link to about" do
    visit "/"

    click_link "About"

    expect(page).to have_current_path("/about")
  end

  it "has a link to signup" do
    visit "/"

    click_link "Sign up"

    expect(page).to have_current_path("/signup")
  end

end
