require "rails_helper"

describe SearchResult do
  describe "#has_post?" do
    it "returns true if there are posts" do
      result = SearchResult.new([double('post')], double('query'))

      expect(result.has_posts?).to eq true
    end

    it "returns false if there are no posts" do
      result = SearchResult.new([], double('query'))

      expect(result.has_posts?).to eq false
    end
  end
end
