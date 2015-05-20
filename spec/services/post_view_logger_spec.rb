require "rails_helper"

describe PostViewLogger do
  describe "#log_view_of" do
    it "logs that the post was viewed" do
      post = double("post", published?: true)
      allow(PostView).to receive(:create!).with(post: post)

      PostViewLogger.new.log_view_of(post)

      expect(PostView).to have_received(:create!).with(post: post)
    end

    it "only logs the view if the post is published" do
      post = double("post", published?: false)
      allow(PostView).to receive(:create!).with(post: post)

      PostViewLogger.new.log_view_of(post)

      expect(PostView).not_to have_received(:create!).with(post: post)
    end
  end
end
