require 'rails_helper'

feature 'creating posts' do
  scenario 'user creates a post' do
    title = "A post"
    create_post(title: title)

    expect(page).to have_content title
    within "article.post strong" do
      expect(page).to have_content "hi"
    end
  end

  scenario 'creates a post with an existing tag' do
    create :tag, name: "JavaScript"

    title = "A post"

    create_post_but_before_save(title: title) do
      check "tag-javascript"
    end

    expect(page).to have_content title
    expect(page).to have_content "JavaScript"
  end

  scenario 'creating a draft and only seeing it in the admin backend' do
    title = "A post"

    create_post_but_before_save(title: title) do
      check "Draft"
    end

    expect(page).not_to have_content title

    visit archives_path
    expect(page).not_to have_content title

    visit admin_path
    expect(page).to have_content title
  end

  def create_post(options = {})
    authenticate
    visit admin_path
    click_link "Create new post"
    fill_in "Title", with: options[:title] || "Learning iOS"
    fill_in "Markdown", with: "**hi**"
    if block_given?
      yield
    end
    click_button "Create post"
    visit root_path
  end

  alias_method :create_post_but_before_save, :create_post
end
