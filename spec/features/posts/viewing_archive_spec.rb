require 'rails_helper'

feature 'viewing archive' do
  scenario 'sees the titles of all the posts but not the content' do
    post = create :post, title: "first post", markdown: "one"
    another_post = create :post, title: "second post", markdown: "two"

    visit root_path
    click_link "Archive"

    expect(page).to have_content post.title
    expect(page).not_to have_content "one"
    expect(page).to have_content another_post.title
    expect(page).not_to have_content "two"
  end
end
