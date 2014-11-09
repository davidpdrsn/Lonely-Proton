require "rails_helper"

feature "viewing archive" do
  scenario "sees the titles of all the posts but not the content" do
    post = create :post, title: "first post", markdown: "foo"
    another_post = create :post, title: "second post", markdown: "bar"

    visit root_path
    click_link "Archive"

    expect(page).to have_content post.title
    expect(page).not_to have_content "foo"
    expect(page).to have_content another_post.title
    expect(page).not_to have_content "bar"
  end
end
