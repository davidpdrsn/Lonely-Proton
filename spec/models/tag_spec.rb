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

      expect(tag == tag).to eq true
      expect(Tag.find(tag.id) == tag).to eq true
    end
  end

  describe ".posts" do
    it "does not include drafts" do
      tag = create :tag
      post = create :post, published_at: nil, tags: [tag]

      expect(tag.posts).to_not include post
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
end
