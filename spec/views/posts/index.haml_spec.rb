require "rails_helper"

describe "posts/index.haml" do
  it "shows when there are no posts" do
    assign :posts, PaginatedCollection.new([], page: 1, per_page: 10)
    render
    expect(rendered).to include "There are no posts yet"
  end
end
