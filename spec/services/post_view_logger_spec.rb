require "rails_helper"

describe PostViewLogger do
  describe "#log_view_of" do
    it "logs that the post was viewed" do
      post = double("post")
      allow(PostView).to receive(:create!).with(post: post)

      PostViewLogger.new.log_view_of(post)

      expect(PostView).to have_received(:create!).with(post: post)
    end
  end
end
