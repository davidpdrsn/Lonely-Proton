require "rails_helper"

feature "viewing top posts" do
  scenario "shows top posts first" do
    popular_post = create :post
    3.times { visit post_path(popular_post) }
    less_popular_post = create :post
    visit post_path(less_popular_post)
    click_link "Best of"

    expect(page.body)
      .to match(/#{popular_post.title}.*#{less_popular_post.title}/m)
  end

  scenario "doesn't show more than 5 posts" do
    5.times do
      post = create :post
      visit post_path(post)
    end
    less_popular_post = create :post

    visit root_path
    click_link "Best of"

    expect(page).to_not have_content less_popular_post.title
  end
end
