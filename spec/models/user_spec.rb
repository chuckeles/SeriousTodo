RSpec.describe User do

  it "is valid with a name and an email" do
    user = User.new(name: "chuckeles", email: "me@chuckeles.me")

    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = User.new(email: "me@chuckeles.me")

    expect(user).to_not be_valid
  end

  it "is invalid with a name that is too long" do
    user = User.new(name: "c" * 33, email: "me@chuckeles.me")

    expect(user).to_not be_valid
  end

  it "is invalid with an existing name" do
    user1 = User.new(name: "chuckeles", email: "me1@chuckeles.me")
    user2 = User.new(name: "chuckeles", email: "me2@chuckeles.me")

    user1.save

    expect(user2).to_not be_valid
  end

  it "is invalid without an email" do
    user = User.new(name: "chuckeles")

    expect(user).to_not be_valid
  end

  it "is invalid with an email that is too long" do
    user = User.new(name: "chuckeles", email: "c" * 243 + "@chuckeles.me")

    expect(user).to_not be_valid
  end

  it "is invalid with an invalid email" do
    user1 = User.new(name: "chuckeles", email: "me")
    user2 = User.new(name: "chuckeles", email: "me.me")
    user3 = User.new(name: "chuckeles", email: "me@me")
    user4 = User.new(name: "chuckeles", email: "me@me..me")

    expect(user1).to_not be_valid
    expect(user2).to_not be_valid
    expect(user3).to_not be_valid
    expect(user4).to_not be_valid
  end

  it "is invalid with an existing email" do
    user1 = User.new(name: "chuckeles1", email: "me@chuckeles.me")
    user2 = User.new(name: "chuckeles2", email: "me@chuckeles.me")
    user3 = User.new(name: "chuckeles3", email: "ME@chuckeles.me")

    user1.save

    expect(user2).to_not be_valid
    expect(user3).to_not be_valid
  end

  it "has email downcased in the database" do
    user = User.new(name: "chuckeles", email: "ME@chuckeles.ME")

    user.save

    expect(user.reload.email).to eq("me@chuckeles.me")
  end

end
