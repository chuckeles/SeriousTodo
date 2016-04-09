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

    it "can find all todo apps of a user" do
      5.times do |i|
        app = TodoApp.new(user_id: @user.id, token: "token#{i}")
        app.sql_insert
      end

      apps = TodoApp.sql_find_by_user(@user.id)

      expect(apps.size).to eq(5)
    end

    it "can count apps by users" do
      user2 = User.new(name: "chuckeles2", email: "me2@chuckeles.me", password: "foobaaaz", password_confirmation: "foobaaaz")
      user2.skip_confirmation!
      user2.save!

      5.times do |i|
        app = TodoApp.new(user_id: @user.id, token: "token#{i}")
        app.sql_insert
      end
      4.times do |i|
        app = TodoApp.new(user_id: user2.id, token: "token#{i}")
        app.sql_insert
      end

      counts = TodoApp.sql_count_by_users_ordered

      expect(counts[0]["todo_apps_count"].to_i).to eq(5)
      expect(counts[1]["todo_apps_count"].to_i).to eq(4)
    end
  end

end
