require "rails_helper"

feature "publishing posts" do
  scenario "creates a draft and some other posts and sees the correct order" do
    draft = create_draft(title: "one")
    create_post(title: "two")

    visit edit_post_path(draft)
    uncheck "Draft"
    click_button "Save post"

    visit root_path
    expect(page.body).to match /#{"one"}.*#{"two"}/m
  end
end
