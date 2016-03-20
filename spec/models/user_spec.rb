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

  it "is invalid without an email" do
    user = User.new(name: "chuckeles")

    expect(user).to_not be_valid
  end

  it "is invalid with an email that is too long" do
    user = User.new(name: "chuckeles", email: "c" * 243 + "@chuckeles.me")

    expect(user).to_not be_valid
  end

  xit "is invalid with an invalid email" do
    user1 = User.new(name: "chuckeles", email: "me")
    user2 = User.new(name: "chuckeles", email: "me.me")
    user3 = User.new(name: "chuckeles", email: "me@me")

    expect(user1).to_not be_valid
    expect(user2).to_not be_valid
    expect(user3).to_not be_valid
  end

end
