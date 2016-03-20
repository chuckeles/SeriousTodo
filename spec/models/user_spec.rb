RSpec.describe User do

  it "is valid with a name and an email" do
    user = User.new(name: "chuckeles", email: "me@chuckeles.me")

    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = User.new(email: "me@chuckeles.me")

    expect(user).to_not be_valid
  end

end
