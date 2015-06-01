require "rails_helper"

feature "pagination" do
  scenario "viewing first page" do
    posts = 11.times.map { |n| create_post(title: "Post #{n}") }
    visit root_path

    expect(page).to have_content Post.recently_published_first.first.title
    expect(page).not_to have_content Post.recently_published_first.last.title
  end

  scenario "navigating to previous page" do
    posts = 11.times.map { |n| create_post(title: "Post #{n}") }
    visit root_path
    click_link "Previously"

    expect(page).to have_content Post.recently_published_first.last.title
    expect(page).not_to have_content Post.recently_published_first.first.title
  end

  scenario "doesn't see previously link when there are no more posts" do
    posts = create :post
    visit root_path

    expect(page).not_to have_content "Previously"
  end
end
