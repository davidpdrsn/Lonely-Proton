require "rails_helper"

describe PostPage do
  describe "#find" do
    it "finds posts and wraps them in a decorator" do
      post = double("post", id: 1337)
      stub_post_model_to_find(post)

      page = PostPage.new(PostDecorator).find(post.id)

      expect(Post).to have_received(:find).with(post.id)
    end

    it "wraps them in a decorator" do
      post = double("post", id: 1337)
      stub_post_model_to_find(post)

      found_post = PostPage.new(PostDecorator).find(post.id)

      expect(found_post.foo).to eq "foo"
    end

    def stub_post_model_to_find(post)
      allow(Post).to receive(:find).with(post.id).and_return(post)
    end
  end

  private

  class PostDecorator < SimpleDelegator
    def foo
      "foo"
    end
  end
end
