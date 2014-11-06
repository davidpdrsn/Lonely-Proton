require "rails_helper"

feature "viewing all tags" do
  scenario "sees all tags" do
    create :tag, name: "Rails"
    create :tag, name: "JavaScript"
    create :tag, name: "Ruby"

    visit root_path
    click_link "Tags"
    expect(page).to have_content "Rails"
    expect(page).to have_content "JavaScript"
    expect(page).to have_content "Ruby"
  end
end
