require 'rails_helper'

describe Tag do
  it { should have_and_belong_to_many :posts }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  describe '#==' do
    it 'is == to a decorated tag' do
      tag = build :tag

      expect(tag == TagWithDomId.new(tag)).to eq true
    end

    it 'is == to the same tag' do
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
end
