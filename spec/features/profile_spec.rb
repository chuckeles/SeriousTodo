RSpec.describe "Profile" do

  before do
    @user = User.new(name: "chuckeles", email: "me@me.me", password: "foobaaaz", password_confirmation: "foobaaaz")
    @user.skip_confirmation!
    @user.save!

    @other_user = User.new(name: "pasto", email: "me2@me.me", password: "foobaaaz", password_confirmation: "foobaaaz")
    @other_user.skip_confirmation!
    @other_user.save!
  end

  it "should be editable if it is the current logged in user" do
    log_in_as_user

    visit user_path(@user)
    click_link "Edit"

    fill_in "Name", with: "nochuckeles"
    click_button "Save"

    user = User.find(@user.id)
    expect(user.name).to eq("nochuckeles")
  end

  def log_in_as_user
    visit new_user_session_path

    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password

    click_button "Log in"
  end

end
