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

  describe "SQL methods", focus: true do
    it "can create a todo app" do
      app = TodoApp.new(user_id: @user.id, token: "secret_token")

      app.sql_insert

      expect(app.id).to be_truthy
      expect(TodoApp.first.token).to eq(app.token)
    end

    it "can update existing todo app" do
      app = TodoApp.new(user_id: @user.id, token: "secret_token")
      app.sql_insert

      app.token = "not_so_secret_eh?"
      app.sql_update

      expect(TodoApp.first.token).to eq(app.token)
    end

    it "can delete a todo app" do
      app = TodoApp.new(user_id: @user.id, token: "secret_token")
      app.sql_insert

      app.sql_delete

      expect(TodoApp.count).to eq(0)
    end

    it "can find by id" do
      app = TodoApp.new(user_id: @user.id, token: "why_dont_you_use_a_before_block...")
      app.sql_insert

      app2 = TodoApp.sql_find_by_id(app.id)

      expect(app2["id"].to_i).to eq(app.id)
      expect(app2["user_id"].to_i).to eq(app.user_id)
      expect(app2["token"]).to eq(app.token)
    end

    it "can find all todo apps of a user"
  end

end
