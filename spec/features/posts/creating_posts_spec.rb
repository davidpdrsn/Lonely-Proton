require 'rails_helper'

feature 'creating posts' do
  scenario 'user creates a post' do
    title = "A post"

    authenticate
    visit admin_path
    click_link "Create new post"
    fill_in "Title", with: title
    fill_in "Markdown", with: "**hi**"
    click_button "Create post"
    visit root_path

    expect(page).to have_content title
    within "article.post strong" do
      expect(page).to have_content 'hi'
    end
  end

  scenario 'creates a post with tags', js: true do
    pending
    title = "A post"

    authenticate
    visit admin_path
    click_link "Create new post"
    fill_in "Title", with: title
    fill_in "Markdown", with: "**hi**"
    fill_in "Tag", with: "javascript"
    click_button "Create tag"
    visit root_path

    expect(page).to have_content title
    within "article.post strong" do
      expect(page).to have_content 'hi'
    end
  end
end
