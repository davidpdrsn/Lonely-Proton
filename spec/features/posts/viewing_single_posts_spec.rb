require 'rails_helper'

feature 'viewing single posts' do
  scenario 'sees the post' do
    post = create :post
    another_post = create :post, title: "another post"

    visit root_path
    click_link post.title

    expect(page).to have_content post.title
    expect(page).not_to have_content another_post.title
  end
end
