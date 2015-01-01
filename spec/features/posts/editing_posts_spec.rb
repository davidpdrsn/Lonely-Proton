require "rails_helper"

feature "editing posts" do
  scenario "user edits the post" do
    create :post, title: "Old title", markdown: "**not good**"
    authenticate
    visit admin_path
    click_link "Edit"
    fill_in "Title", with: "New title"
    fill_in "Markdown", with: "**content**"
    click_button "Save post"
    visit root_path

    expect(page).to have_content "New title"
    expect(page).to have_css("strong", text: "content")
  end

  scenario "edits the tag of a post" do
    tag = create :tag, name: "JavaScript"
    new_tag = create :tag, name: "Ruby"
    create :post, tags: [tag]

    authenticate
    visit admin_path
    click_link "Edit"
    uncheck "tag-javascript"
    check "tag-ruby"
    click_button "Save post"

    expect(page).to have_content new_tag.name
    expect(page).not_to have_content tag.name
  end

  scenario "doesn't change slug when changing title" do
    post = create :post, title: "Old title"
    visit post_path(post)
    old_path = page.current_path

    authenticate
    visit admin_path
    click_link "Edit"
    fill_in "Title", with: "New title"
    click_button "Save post"

    visit post_path(post)
    new_path = page.current_path

    expect(old_path).to eq new_path
  end
end
