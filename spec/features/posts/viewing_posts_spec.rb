require "rails_helper"

feature "viewing posts" do
  scenario "sees when there are no posts" do
    visit root_path
    expect(page).to have_content "There are no posts yet"
  end

  scenario "sees the posts" do
    create_post_and_visit_root(title: "its all good")

    expect(page).to have_content "its all good"
  end

  scenario "sees the date the post was created" do
    create_post_and_visit_root created_at: Time.parse("2001-12-12 20")

    within "article.post" do
      expect(page).to have_content "12/12/2001"
    end
  end

  def create_post_and_visit_root(options = {})
    create :post, options
    visit root_path
  end
end
