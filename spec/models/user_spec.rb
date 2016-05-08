RSpec.fdescribe User do

  subject(:valid_user) do
    User.new(
      name: "chuckeles",
      email: "me@chuckeles.me",
      password: "foobazzz123",
      password_confirmation: "foobazzz123"
    )
  end

  context "with name, email and password" do
    it { is_expected.to be_valid }
  end

  context "without a name" do
    subject do
      user = valid_user.dup
      user.name = ""
      user
    end

    it { is_expected.to_not be_valid }
  end

  context "with an existing name" do
    subject do
      valid_user.save!
      valid_user.dup
    end

    it { is_expected.to_not be_valid }
  end

  context "with an invalid name" do
    subject do
      user = valid_user.dup
      user.name = "not coo$$"
      user
    end

    it { is_expected.to_not be_valid }
  end

  context "without an email" do
    subject do
      user = valid_user.dup
      user.email = ""
      user
    end

    it { is_expected.to_not be_valid }
  end

  context "with an invalid email" do
    subject do
      user = valid_user.dup
      user.email = "me.me"
      user
    end

    it { is_expected.to_not be_valid }
  end

  context "with an existing email" do
    subject do
      valid_user.save!

      user = valid_user.dup
      user.email = "ME@chuckeles.ME"
      user
    end

    it { is_expected.to_not be_valid }
  end

  context "without a password" do
    subject do
      user = valid_user.dup
      user.password = user.password_confirmation = ""
      user
    end

    it { is_expected.to_not be_valid }
  end

  context "is invalid with a short password" do
    subject do
      user = valid_user.dup
      user.password = user.password_confirmation = "short"
      user
    end

    it { is_expected.to_not be_valid }
  end

end
