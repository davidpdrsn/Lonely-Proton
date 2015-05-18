require "rails_helper"

describe PopularPostsFinder do
  describe "#find_posts" do
    it "returns posts sorted by their number of views" do
      one = double("one", number_of_views: 10)
      two = double("two", number_of_views: 5)
      three = double("three", number_of_views: 1)
      allow(Post).to receive(:all).and_return([two, three, one])

      finder = PopularPostsFinder.new

      result = finder.find_posts.map(&:number_of_views)
      expect(result).to eq [one, two, three].map(&:number_of_views)
    end

    it "doesn't return more than three posts" do
      posts = 10.times.map { double("one", number_of_views: 10) }
      allow(Post).to receive(:all).and_return(posts)

      finder = PopularPostsFinder.new

      expect(finder.find_posts.count).to eq 5
    end
  end
end
