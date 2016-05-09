RSpec.fdescribe "Todo App" do

  context "when no todo-app is connected" do
    before do
      stub_todo_apps
      visit todo_apps_connect_path
    end

    xit "allows to connect Todoist" do
      click_link "Connect Todoist" # TODO: why on Earth does this go to my router when the link
                                   #       is https://todoist.com/oauth/authorize ????????!!!!!

      expect(page).to have_content("Todoist connected.")
      expect(user.reload.todo_apps.size).to eq(1)
    end
  end

  context "when a todo-app is connected" do
    before do
      user.todo_apps.create!(token: "123")
      visit todo_apps_disconnect_path
    end

    it "allows to disconnect Todoist" do
      click_link "Disconnect Todoist"

      expect(page).to have_content("Todoist disconnected.")
      expect(user.reload.todo_apps).to be_empty
    end
  end

  before do
    log_in_user
  end

  let(:user) do
    user = User.new(
      name: "chuckeles",
      email: "me@chuckeles.me",
      password: "foobaaaz123",
      password_confirmation: "foobaaaz123"
    )
    user.skip_confirmation!
    user.save!
    user
  end

  def log_in_user
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"
  end

  def stub_todo_apps
    stub_request(:get, "https://todoist.com/oauth/authorize")
      .to_return(body: "")
  end

end
