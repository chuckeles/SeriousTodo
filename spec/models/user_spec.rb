RSpec.describe User do

  before do
    @user = User.new(name: "chuckeles", email: "me@chuckeles.me", password: "foo", password_confirmation: "foo")
  end

  it "is valid with a name and an email" do
    expect(@user).to be_valid
  end

  it "is invalid without a name" do
    @user.name = ""

    expect(@user).to_not be_valid
  end

  it "is invalid with a name that is too long" do
    @user.name = "c" * 33

    expect(@user).to_not be_valid
  end

  it "is invalid with an existing name" do
    @user.save
    user2 = @user.dup

    expect(user2).to_not be_valid
  end

  it "is invalid without an email" do
    @user.email = ""

    expect(@user).to_not be_valid
  end

  it "is invalid with an email that is too long" do
    @user.email = "c" * 243 + "@chuckeles.me"

    expect(@user).to_not be_valid
  end

  it "is invalid with an invalid email" do
    user1 = @user.dup
    user2 = @user.dup
    user3 = @user.dup
    user4 = @user.dup

    user1.email = "me"
    user2.email = "me.me"
    user3.email = "me@me"
    user4.email = "me@me..me"

    expect(user1).to_not be_valid
    expect(user2).to_not be_valid
    expect(user3).to_not be_valid
    expect(user4).to_not be_valid
  end

  it "is invalid with an existing email" do
    user1 = @user.dup
    user2 = @user.dup
    user3 = @user.dup

    user1.email = "me@chuckeles.ME"
    user2.email = "me@chuckeles.me"
    user3.email = "ME@chuckeles.me"

    @user.save

    expect(user1).to_not be_valid
    expect(user2).to_not be_valid
    expect(user3).to_not be_valid
  end

  it "has email downcased in the database" do
    @user.email = "ME@chuckeles.ME"

    @user.save

    expect(@user.reload.email).to eq("me@chuckeles.me")
  end

end
