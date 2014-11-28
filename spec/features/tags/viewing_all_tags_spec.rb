require "rails_helper"

feature "viewing all tags" do
  scenario "sees tags that have posts associated with them" do
    tag = create :tag, name: "Rails"
    create :post, tags: [tag]

    visit root_path
    click_link "Tags"
    expect(page).to have_content "Rails"
  end

  scenario "doesn't see tags that have no posts associated with them" do
    create :tag, name: "Cooking"

    visit root_path
    click_link "Tags"
    expect(page).not_to have_content "Cooking"
  end
end
