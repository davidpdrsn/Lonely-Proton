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

  scenario 'creates a post with an existing tag' do
    create :tag, name: "JavaScript"

    title = "A post"

    authenticate
    visit admin_path
    click_link "Create new post"
    fill_in "Title", with: title
    fill_in "Markdown", with: "**hi**"
    check "tag-javascript"
    click_button "Create post"
    visit root_path

    expect(page).to have_content title
    expect(page).to have_content "JavaScript"
  end

  xscenario 'creates a post with a new tag', js: true do
    title = "A post"

    authenticate
    visit admin_path
    click_link "Create new post"
    fill_in "Title", with: title
    fill_in "Markdown", with: "**hi**"
    fill_in "New tag", with: "Functional programming"
    click_button "Add tag"
    click_button "Create post"
    visit root_path

    expect(page).to have_content title
    expect(page).to have_content "Functional programming"
  end
end
