require 'rails_helper'

describe 'posts/index.haml' do
  it 'shows when there are no posts' do
    assign :posts, []
    render
    expect(rendered).to include 'There are no posts yet'
  end
end
