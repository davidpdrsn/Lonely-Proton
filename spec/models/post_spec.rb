require_relative '../../lib/markdown_parser'
require 'rails_helper'

describe Post do
  it { should validate_presence_of :title }
  it { should validate_presence_of :markdown }
  it { should have_and_belong_to_many :tags }

  it 'should validate uniqueness of title' do
    post = create :post, title: "title"
    expect(build :post, title: "title").to_not be_valid
  end

  it 'automatically generates its html before save' do
    markdown = '**hi**'
    html = '<p><strong>hi</strong></p>'
    parser = double('markdown_parser')
    allow(parser).to receive(:parse).with(markdown).and_return(html)
    allow(MarkdownParser).to receive(:new).and_return(parser)

    post = build(:post, markdown: markdown)
    post.save

    expect(parser).to have_received(:parse).with(markdown)
    expect(post.html).to eq html
  end

  describe ".recently_published_first" do
    it "returns the posts in the order they were published" do
      create :post, title: "new", published_at: Time.now
      create :post, title: "old", published_at: 10.days.ago
      create :post, title: "middle", published_at: 5.days.ago

      expect(Post.recently_published_first.map(&:title)).to eq ["new",
                                                                "middle",
                                                                "old"]
    end

    it "does not include posts that aren't published" do
      post = create :post, published_at: nil
      expect(Post.recently_published_first).to_not eq [post]
    end
  end

  describe ".recently_created_first" do
    it "returns the posts in the order they were created" do
      create :post, title: "new", created_at: Time.now
      create :post, title: "old", created_at: 10.days.ago
      create :post, title: "middle", created_at: 5.days.ago

      expect(Post.recently_created_first.map(&:title)).to eq ["new",
                                                              "middle",
                                                              "old"]
    end
  end

  describe "#published?" do
    it "returns true if the post is published" do
      post = build_stubbed :post, published_at: Time.now
      expect(post.published?).to be_truthy
    end

    it "returns false is the post is not published" do
      post = build_stubbed :post, published_at: nil
      expect(post.published?).to be_falsy
    end

    it "returns false if the post has not yet been published" do
      expect(Post.new.published?).to be_falsy
    end
  end

  describe "#draft?" do
    it "returns true if the post is not published" do
      post = build_stubbed(:post, published_at: nil)
      expect(post.draft?).to be_truthy
    end

    it "returns false if the post is published" do
      post = build_stubbed(:post, published_at: Time.now)
      expect(post.draft?).to be_falsy
    end

    it "returns false if the post has not been saved" do
      expect(Post.new.draft?).to be_falsy
    end
  end
end
