# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  markdown     :text
#  created_at   :datetime
#  updated_at   :datetime
#  html         :text
#  link         :string(255)
#  published_at :datetime
#  slug         :string(255)
#

require "rails_helper"

describe Post do
  it { should validate_presence_of :title }
  it { should validate_presence_of :markdown }
  it { should validate_presence_of :slug }
  it { should validate_uniqueness_of :slug }

  it { should have_and_belong_to_many :tags }

  it "should validate uniqueness of title" do
    create :post, title: "title"
    expect(build :post, title: "title").to_not be_valid
  end

  describe ".drafts" do
    it "returns the drafts" do
      create :post, title: "published"
      create :post, published_at: nil, title: "draft"

      expect(Post.drafts.map(&:title)).to eq ["draft"]
    end
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

  describe ".where_content_or_title_matches" do
    it "returns posts with matching title" do
      post = create :post, title: "javascript"
      results = Post.where_content_or_title_matches("javascript")

      expect(results).to eq [post]
    end

    it "returns posts with matching body" do
      post = create :post, title: "javascript", markdown: "html"
      results = Post.where_content_or_title_matches("html")

      expect(results).to eq [post]
    end

    it "searches for substrings as well" do
      post = create :post, title: "javascript"
      results = Post.where_content_or_title_matches("java")

      expect(results).to eq [post]
    end

    it "returns an empty array when there are no posts" do
      create :post, title: "javascript"
      results = Post.where_content_or_title_matches("no matches")

      expect(results).to eq []
    end

    it "is case insensitive" do
      post = create :post, title: "jAVAScript"
      results = Post.where_content_or_title_matches("javascRIPt")

      expect(results).to eq [post]
    end

    it "does not include drafts" do
      create :post, title: "javascript", published_at: nil
      results = Post.where_content_or_title_matches("javascript")

      expect(results).to eq []
    end

    it "returns the results sorted by when they were published" do
      create :post, title: "post 1", published_at: Time.now
      create :post, title: "post 3", published_at: 20.minutes.ago
      create :post, title: "post 2", published_at: 10.minutes.ago
      results = Post.where_content_or_title_matches("post")

      expect(results.map(&:title)).to eq ["post 1", "post 2", "post 3"]
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
