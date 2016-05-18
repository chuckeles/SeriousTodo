RSpec.fdescribe Pledge do

  context "with a task id and a positive amount" do
    it { is_expected.to be_valid }
  end

  subject(:valid_pledge) do
    Pledge.new(
      task_id: "ab1234c",
      amount: 14.5
    )
  end

end
