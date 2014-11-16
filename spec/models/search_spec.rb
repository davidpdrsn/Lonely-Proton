require "rails_helper"

describe Search do
  describe "#for" do
    it "delegates to Post and builds a SearchResult" do
      query = "JavaScript"
      post = double("post")
      posts = [post]
      results = double("results")

      allow(Post).to receive(:where_content_or_title_matches)
        .with(query)
        .and_return(posts)
      allow(SearchResult).to receive(:new).and_return(results)

      actual_results = Search.new.for(query)

      expect(actual_results).to eq results
      expect(SearchResult).to have_received(:new).with(posts, query)
    end
  end
end
