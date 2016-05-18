RSpec.describe Pledge do

  context "with a task id and a positive amount" do
    it { is_expected.to be_valid }
  end

  context "without a task id" do
    subject do
      pledge = valid_pledge.dup
      pledge.task_id = nil
      pledge
    end

    it { is_expected.to_not be_valid }
  end

  context "without an amount" do
    subject do
      pledge = valid_pledge.dup
      pledge.amount = nil
      pledge
    end

    it { is_expected.to_not be_valid }
  end

  context "with a negative amount" do
    subject do
      pledge = valid_pledge.dup
      pledge.amount = -10.0
      pledge
    end

    it { is_expected.to_not be_valid }
  end

  context "with a string amount" do
    subject do
      pledge = valid_pledge.dup
      pledge.amount = "string"
      pledge
    end

    it { is_expected.to_not be_valid }
  end

  subject(:valid_pledge) do
    Pledge.new(
      task_id: "ab1234c",
      amount: 14.5
    )
  end

end
