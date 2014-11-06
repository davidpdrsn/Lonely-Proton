require "rails_helper"

feature "viewing posts with a single tag" do
  scenario "sees the posts" do
    tag = create :tag, name: "Rails"
    post = create :post, tags: [tag]

    visit root_path
    click_link "Tags"
    click_link "Rails"
    expect(page).to have_content "Rails"
    expect(page).to have_link post.title
  end
end
