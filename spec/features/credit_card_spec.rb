RSpec.fdescribe "Credit Card" do

  context "with existing credit card" do
    before do
      user.customer_id = 1
      user.save!
    end

    it "allows to remove the credit card" do
      visit users_credit_card_path
      click_link "Delete credit card"

      expect(user.reload.customer_id).to be_nil
    end
  end

  context "without existing credit card" do
    it "allows to add a new credit card" do
      visit users_credit_card_path
      fill_in_credit_card_details

      expect(page).to have_button("Submit")
    end
  end

  before do
    log_in_user
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

  def log_in_user
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"
  end

  def fill_in_credit_card_details
    fill_in "card_number", with: "4242424242424242"
    fill_in "card_cvc", with: "000"
  end

end
