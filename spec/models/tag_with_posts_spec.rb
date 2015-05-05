require "rails_helper"

describe TagWithPosts do
  describe "#posts" do
    it "wraps the tags posts in a decorator" do
      post = double("post")
      tag = double("tag", posts: [post])
      decorator = double("decorator")
      allow(decorator).to receive(:new).with([post])

      TagWithPosts.new(tag, decorator).posts

      expect(decorator).to have_received(:new).with([post])
    end

    it "delegates other methods to the tag" do
      post = double("post")
      tag = double("tag", posts: [post])
      allow(tag).to receive(:foo)
      decorator = double("decorator")

      TagWithPosts.new(tag, decorator).foo

      expect(tag).to have_received(:foo)
    end
  end
end
