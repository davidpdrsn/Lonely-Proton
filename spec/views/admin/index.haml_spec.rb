require "rails_helper"

describe "admin/index.haml" do
  it "shows when a post is not a draft" do
    post = build_stubbed :post, published_at: Time.now
    assign(:posts, [post])
    render
    expect(rendered).not_to include "(draft)"
  end

  it "shows when a post is a draft" do
    post = build_stubbed :post, published_at: nil
    assign(:posts, [post])
    render
    expect(rendered).to include "(draft)"
  end
end
