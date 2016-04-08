RSpec.describe TodoApp do

  before do
    @user = User.new(name: "chuckeles", email: "me@chuckeles.me", password: "foobaaaz", password_confirmation: "foobaaaz")
    @user.skip_confirmation!
    @user.save!
  end

  it "belongs to a user" do
    app = @user.todo_apps.create(token: "123")

    expect(app.user).to eq(@user)
    expect(app.token).to eq("123")
  end

  it "is not valid without a token" do
    app = @user.todo_apps.build

    expect(app).to_not be_valid
  end

  describe "SQL methods" do
    it "can create a todo app" do
      app = TodoApp.new(user_id: @user.id, token: "secret_token")

      app.sql_insert

      expect(TodoApp.first.token).to eq(app.token)
    end
  end

end
