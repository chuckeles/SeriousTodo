require "rails_helper"

RSpec.feature "Homepage navigation" do

  scenario "User clicks about link" do
    visit "/"

    click_link "About"

    expect(page).to have_current_path("/about")
  end

end
