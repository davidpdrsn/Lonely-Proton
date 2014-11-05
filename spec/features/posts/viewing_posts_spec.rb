require "rails_helper"

feature "viewing posts" do
  scenario "sees when there are no posts" do
    visit root_path
    expect(page).to have_content "There are no posts yet"
  end

  scenario "sees the posts", focus: true do
    post = create :post

    visit root_path

    expect(page).to have_content post.title
  end

  scenario "sees the parsed markdown as html" do
    create :post, markdown: "**hi**"
    visit root_path
    within "article.post strong" do
      expect(page).to have_content "hi"
    end
  end

  scenario "sees the date the post was created" do
    create :post, created_at: Time.parse("2001-12-12 20")

    visit root_path

    within "article.post" do
      expect(page).to have_content "12/12/2001"
    end
  end
end
