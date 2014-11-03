require 'rails_helper'

feature 'editing posts' do
  scenario 'user edits the post' do
    post = create :post, title: "Old title"
    authenticate
    visit admin_path
    click_link "Edit"
    fill_in "Title", with: "New title"
    click_button "Save post"
    visit root_path

    expect(page).to have_content "New title"
  end
end
