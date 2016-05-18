require "aes"

RSpec.describe "Tasks" do

  context "when not logged in" do
    it "redirects to login" do
      visit tasks_path

      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context "when logged in" do
    before do
      log_in_user
    end

    context "when no app is connected" do
      it "redirects to connect" do
        visit tasks_path

        expect(page).to have_current_path(todo_apps_connect_path)
      end
    end

    context "when an app is connected" do
      before do
        connect_todo_app
        stub_todo_apps
      end

      it "shows the tasks" do
        visit tasks_path

        expect(page).to have_content("Important task")
      end
    end
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

  let(:token) do
    "thisisatoken"
  end

  def log_in_user
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"
  end

  def connect_todo_app
    user.todo_apps.create!(token: AES.encrypt(token, Rails.application.secrets.secret_key_base))
  end

  def stub_todo_apps
    stub_request(:post, "https://todoist.com/API/v6/sync")
      .to_return(body: '{ "Items": [{ "id": 123, "content": "Important task" }] }')
  end

end
