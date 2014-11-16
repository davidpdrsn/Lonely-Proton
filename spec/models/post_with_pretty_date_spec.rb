require "rails_helper"

describe PostWithPrettyDate do
  describe "#pretty_date" do
    it "returns a pretty representation of the created at date" do
      post = double("post", created_at: make_date("2011-12-12 20"))
      post_with_pretty_date = PostWithPrettyDate.new(post)

      expect(post_with_pretty_date.pretty_date).to eq "12/12/2011"
    end
  end

  def make_date(format)
    ActiveSupport::TimeZone["Sydney"].parse(format)
  end
end
