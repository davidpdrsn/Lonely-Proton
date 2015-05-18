require "rails_helper"

describe PostPage do
  describe "#find" do
    it "finds posts and wraps them in a decorator" do
      post = double("post", id: id)
      stub_post_model_to_find(post)
      logger = stubbed_logger(post)

      found_post = PostPage.new(decorator: PostDecorator, logger: logger)
        .find(post.id)

      expect(Post).to have_received(:find).with(post.id)
    end

    it "wraps them in a decorator" do
      post = double("post", id: id)
      stub_post_model_to_find(post)
      logger = stubbed_logger(post)

      found_post = PostPage.new(decorator: PostDecorator, logger: logger)
        .find(post.id)

      expect(found_post.foo).to eq "foo"
    end

    it "logs that the post was viewed" do
      post = double("post", id: id)
      stub_post_model_to_find(post)
      logger = stubbed_logger(post)

      PostPage.new(decorator: PostDecorator, logger: logger).find(post.id)

      expect(logger).to have_received(:log_view_of).with(post)
    end

    let(:id) { 1337 }

    def stubbed_logger(post)
      logger = double("post view logger")
      allow(logger).to receive(:log_view_of).with(post)
      logger
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
