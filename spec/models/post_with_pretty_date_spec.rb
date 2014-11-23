require_relative "../../app/models/post_with_pretty_date"

describe PostWithPrettyDate do
  describe "#pretty_date" do
    it "returns a pretty representation of the published at date" do
      post = double("post", published_at: make_date("2011-12-12 20"))
      post_with_pretty_date = PostWithPrettyDate.new(post)

      expect(post_with_pretty_date.pretty_date).to eq "12/12/2011"
    end

    it "uses created at when the post is not published yet" do
      draft = double(
        "draft",
        published_at: nil,
        created_at: make_date("2011-12-12 20"),
      )

      draft_with_pretty_date = PostWithPrettyDate.new(draft)

      expect(draft_with_pretty_date.pretty_date).to eq "12/12/2011"
    end
  end

  def make_date(format)
    ActiveSupport::TimeZone["Sydney"].parse(format)
  end
end
