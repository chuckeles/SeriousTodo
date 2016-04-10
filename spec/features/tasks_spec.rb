require "aes"

RSpec.describe "Tasks" do

  before do
    @user = User.new(name: "chuckeles", email: "me@chuckeles.me", password: "foobaaaz", password_confirmation: "foobaaaz")
    @user.skip_confirmation!
    @user.save!
  end

  it "redirect to login when no user is logged in" do
    visit tasks_path

    expect(page).to have_current_path(new_user_session_path)
  end

  it "redirect to connect when no app is connected" do
    log_in

    visit tasks_path

    expect(page).to have_current_path(todo_apps_connect_path)
  end

  def log_in
    visit new_user_session_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"
  end

  def connect_todo_app
    @user.todo_apps.create(token: AES.encrypt("what_is_this_huh", Rails.application.secrets.secret_key_base))
  end

end
