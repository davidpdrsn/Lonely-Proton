# == Schema Information
#
# Table name: tags
#
#  id   :integer          not null, primary key
#  name :string(255)
#

require "rails_helper"

describe Tag do
  it { should have_and_belong_to_many :posts }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  describe "#==" do
    it "is == to a decorated tag" do
      tag = build :tag

      expect(tag == TagWithDomId.new(tag)).to eq true
    end

    it "is == to the same tag" do
      tag = create :tag

      expect(Tag.find(tag.id) == tag).to eq true
    end
  end

  describe ".posts" do
    it "does not include drafts" do
      tag = create :tag
      post = create :post, published_at: nil, tags: [tag]

      expect(tag.posts).to_not include post
    end

    it "shows newest post first" do
      tag = create :tag
      create :post, title: "first", published_at: 10.minutes.ago, tags: [tag]
      create :post, title: "last", published_at: 30.minutes.ago, tags: [tag]
      create :post, title: "middle", published_at: 20.minutes.ago, tags: [tag]

      expect(tag.posts.map(&:title)).to eq ["first", "middle", "last"]
    end
  end

  describe ".find_for_ids" do
    it "returns the tags with the ids" do
      tag = create :tag, name: "expected"
      create :tag, name: "not expected"

      found_tags = Tag.find_for_ids([tag.id])
      expect(found_tags.map(&:name)).to eq ["expected"]
    end

    it "doesn't care if the ids are strings or ints" do
      tag = create :tag, name: "expected"
      create :tag, name: "not expected"

      ids_as_strings = [tag.id].map(&:to_s)
      found_tags = Tag.find_for_ids(ids_as_strings)
      expect(found_tags.map(&:name)).to eq ["expected"]
    end
  end

  describe ".tags_with_posts" do
    it "returns the tags that have posts" do
      rails = create :tag, name: "Rails"
      javascript = create :tag, name: "JavaScript"
      create :tag, name: "Cooking"

      create :post, tags: [rails, javascript]

      expect(Tag.tags_with_posts).to eq [rails, javascript]
    end

    it "does not include tags that only have draft posts" do
      rails = create :tag, name: "Rails"
      javascript = create :tag, name: "JavaScript"

      create :post, published_at: nil, tags: [javascript]
      create :post, tags: [rails]

      expect(Tag.tags_with_posts).to eq [rails]
    end
  end
end
