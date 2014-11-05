require "rails_helper"

describe "admin/index.haml" do
  it "shows when a post is not a draft" do
    post = build_stubbed :post, draft: false
    assign(:posts, [post])
    render
    expect(rendered).not_to include "(draft)"
  end

  it "shows when a post is a draft" do
    post = build_stubbed :post, draft: true
    assign(:posts, [post])
    render
    expect(rendered).to include "(draft)"
  end
end
