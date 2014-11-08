require "rails_helper"

describe "posts/show.haml" do
  it "shows a link to the post if its a link" do
    post = stubbed_post
    assign(:post, post)

    expect(page).not_to have_css("a.external-link", text: post.title)
    expect(page).to have_content(post.title)
  end

  it "shows the linked item if the post is a linked list style post" do
    post = stubbed_post(link: "google.com")
    assign(:post, post)

    expect(page).to have_css("a.external-link", text: post.title)
  end

  it "shows a link to the tag" do
    tag = create(:tag)
    post = create(:post, tags: [tag])
    assign(:post, PostWithPrettyDate.new(post))

    expect(page).to have_link tag.name
  end

  it "shows if the post is a draft" do
    post = stubbed_post(published_at: nil)
    assign(:post, post)

    expect(page).to have_content "(draft)"
  end

  it "shows when the post is not a draft" do
    post = stubbed_post(published_at: Time.now)
    assign(:post, post)

    expect(page).not_to have_content "(draft)"
  end

  def stubbed_post(options = {})
    post = PostWithPrettyDate.new(build_stubbed(:post, options))
    allow(post).to receive(:html).and_return("")
    allow(post).to receive(:pretty_date).and_return("")
    post
  end
end
