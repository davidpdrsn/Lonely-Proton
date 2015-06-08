require "rails_helper"

describe "creating a post" do
  before { http_login }

  context "with valid attributes" do
    it "creates it" do
      attributes = post_attributes(tags: [tag])

      authorized_post("/api/admin/posts", post: attributes)

      expect(response.status).to eq 200
      expect(Post.count).to eq 1
      expect(Post.last.title).to eq attributes[:title]
      expect(Post.last.tags).to eq [tag]
    end

    it "creates drafts" do
      attributes = post_attributes

      authorized_post("/api/admin/posts", post: attributes, draft: true)

      expect(Post.last.published?).to eq false
    end

    let(:tag) { create :tag }

    def post_attributes(tags: [])
      attributes_for(:post).merge(tag_ids: tags.map(&:id))
    end
  end

  context "with invalid attributes" do
    it "doesn't create it" do
      attributes = attributes_for :post, title: ""

      authorized_post("/api/admin/posts", post: attributes)

      expect(response.status).to eq 422
      expect(Post.count).to eq 0
    end
  end
end
