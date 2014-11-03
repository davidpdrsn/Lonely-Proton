require 'rails_helper'

describe 'archives/index.haml' do
  it 'shows when there are no posts' do
    assign :posts, []
    render
    expect(rendered).to include "There are no posts yet"
  end

  it 'shows the titles of all the posts' do
    post = create :post, markdown: "markdown"
    assign :posts, [post]
    render
    expect(rendered).to include post.title
    expect(rendered).not_to include "markdown"
  end
end
