require "rails_helper"

feature "searching for posts" do
  scenario "seeing the posts" do
    create :post, title: "JavaScript"
    visit root_path
    fill_in "query", with: "javascript"
    click_button "Search"

    expect(page).to have_content "JavaScript"
  end
end
