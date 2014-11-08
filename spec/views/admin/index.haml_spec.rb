require "rails_helper"

describe "admin/index.haml" do
  it "shows when there are no posts" do
    posts = double("posts", published: [], drafts: [])
    assign(:posts, posts)
    render

    expect(rendered).to match /There are no drafts yet/
    expect(rendered).to match /There are no published posts yet/
  end

  it "shows the published posts" do
    published = build_stubbed(:post)
    posts = double("posts", published: [published], drafts: [])
    assign(:posts, posts)
    render

    expect(rendered).to match /There are no drafts yet/
    expect(rendered).not_to match /There are no published posts yet/
    expect(rendered).to match /#{published.title}/
  end

  it "shows the draft posts" do
    draft = build_stubbed(:post)
    posts = double("posts", published: [], drafts: [draft])
    assign(:posts, posts)
    render

    expect(rendered).not_to match /There are no drafts yet/
    expect(rendered).to match /There are no published posts yet/
    expect(rendered).to match /#{draft.title}/
  end
end
