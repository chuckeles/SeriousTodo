RSpec.describe "users/show.html.slim" do

  it "displays the user" do
    assign(:user, User.new(name: "chuckeles", email: "me@chuckeles.me"))

    render

    expect(rendered).to have_css("img[alt=chuckeles]")
    expect(rendered).to have_css("p", text: "chuckeles")
    expect(rendered).to have_css("p", text: "me@chuckeles.me")
  end

end
