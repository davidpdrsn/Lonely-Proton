require 'rails_helper'

feature 'viewing markdown preview' do
  scenario 'shows live markdown preview', js: true do
    title = "A post"

    authenticate
    visit admin_path
    click_link "Create new post"
    fill_in "Markdown", with: "**hi**"

    expect(page).to have_content "hi"
  end
end
