require "rails_helper"

feature "viewing all tags" do
  scenario "sees tags that have posts associated with them" do
    tag = create :tag, name: "Rails"
    create :post, tags: [tag]

    visit root_path
    click_link "Tags"
    expect(page).to have_content "Rails"
  end

  scenario "sees the number of posts associated with the given tag" do
    rails = create :tag, name: "Rails"
    create :post, tags: [rails]

    cooking = create :tag, name: "Cooking"
    create :post, tags: [cooking]
    create :post, tags: [cooking]

    visit root_path
    click_link "Tags"
    expect(page).to have_content "Rails (1 post)"
    expect(page).to have_content "Cooking (2 posts)"
  end

  scenario "doesn't see tags that have no posts associated with them" do
    create :tag, name: "Cooking"

    visit root_path
    click_link "Tags"
    expect(page).not_to have_content "Cooking"
  end
end
