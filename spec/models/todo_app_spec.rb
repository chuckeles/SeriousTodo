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

end
