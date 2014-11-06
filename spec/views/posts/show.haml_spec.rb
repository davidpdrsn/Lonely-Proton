require "rails_helper"

describe "posts/show.haml" do
  it "shows a link to the post if its a link"
  it "shows the linked item if the post is a linked list style post"

  it "shows a link to the tag" do
    tag = create(:tag)
    post = create(:post, tags: [tag])
    assign(:post, PostWithPrettyDate.new(post))

    expect(page).to have_link tag.name
  end
end
