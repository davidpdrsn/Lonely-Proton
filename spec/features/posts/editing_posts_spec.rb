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

  scenario 'edits the tag of a post' do
    tag = create :tag, name: "JavaScript"
    new_tag = create :tag, name: "Ruby"
    post = create :post, tags: [tag]

    authenticate
    visit admin_path
    click_link "Edit"
    uncheck "tag-javascript"
    check "tag-ruby"
    click_button "Save post"

    expect(page).to have_content new_tag.name
    expect(page).not_to have_content tag.name
  end
end
