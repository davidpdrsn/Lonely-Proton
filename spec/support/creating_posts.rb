def create_post(options = {})
  authenticate
  visit admin_path
  click_link "Create new post"
  fill_in "Title", with: options[:title] || attributes_for(:post)[:title]
  fill_in "Markdown", with: options[:markdown] ||
    attributes_for(:post)[:markdown]
  yield if block_given?
  click_button "Create post"

  Post.last
end

def create_post_but_before_save(*args, &block)
  create_post(*args) do
    block.call
  end
end

def create_draft(options = {})
  create_post_but_before_save(options) do
    check "Draft"
  end
end
