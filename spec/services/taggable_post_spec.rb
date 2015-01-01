require "rails_helper"

describe TaggablePost do
  it "adds tags to a post when the post is saved" do
    raw_post = double("raw_post")
    allow(raw_post).to receive(:save)
    allow(raw_post).to receive(:tags=)
    tag = double("tag")
    tags = [tag]
    post = TaggablePost.new(raw_post, tags)
    allow(post).to receive(:tags=).with(tags)

    post.save

    expect(raw_post).to have_received(:save)
    expect(raw_post).to have_received(:tags=).with(tags)
  end
end
