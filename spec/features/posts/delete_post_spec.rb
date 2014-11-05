require "rails_helper"

feature "deleting posts" do
  scenario "deleting post" do
    post = create :post
    authenticate
    visit admin_path
    click_link "Destroy"

    expect(page).not_to have_content post.title
  end
end
