require "rails_helper"

describe PostsController do
  describe "#index" do
    it "shows the newest post first and only drafts" do
      allow(Post).to receive(:sorted).and_return(Post)
      allow(Post).to receive(:published)

      get :index

      expect(Post).to have_received(:sorted)
      expect(Post).to have_received(:published)
    end
  end

  describe "#create" do
    it "requires authentication" do
      post :create, post: { title: "title", markdown: "markdown" }
      expect(response.status).to eq 401
    end

    it "creates the post if its valid" do
      http_login

      expect do
        post :create, post: {
          title: "title",
          markdown: "markdown",
          link: "http://google.com",
          draft: true,
        }
      end.to change { Post.count }.by 1

      expect(subject).to redirect_to Post.last
      expect(Post.last.link).to eq "http://google.com"
      expect(Post.last.draft?).to eq true
    end

    it "creates the post with tags" do
      http_login
      tag = create :tag

      post :create, post: {
        title: "title",
        markdown: "markdown",
        tag_ids: [tag.id.to_s],
      }

      expect(Post.last.tags).to include tag
    end

    it "does not create the post if its invalid" do
      http_login

      expect do
        post :create, post: { title: nil, markdown: "markdown" }
      end.not_to change { Post.count }

      expect(subject).to set_the_flash[:alert]
      expect(subject).to render_template :new
    end
  end

  describe "#new" do
    it "requires authentication" do
      get :new
      expect(response.status).to eq 401
    end
  end

  describe "#edit" do
    it "requires authentication" do
      get :edit, id: 1
      expect(response.status).to eq 401
    end
  end

  describe "#update" do
    it "updates the post" do
      http_login
      post = create :post, title: "Old title"
      patch :update, id: post.id, post: { title: "New title" }

      expect(Post.find(post.id).title).to eq "New title"
      expect(subject).to set_the_flash[:notice]
    end

    it "updates the tags" do
      http_login
      tag = create :tag, name: "javascript"
      new_tag = create :tag, name: "ruby"
      post = create :post, tags: [tag]
      patch :update, id: post.id, post: { tag_ids: [new_tag.id.to_s] }

      expect(Post.find(post.id).tags).to include new_tag
      expect(Post.find(post.id).tags).not_to include tag
    end

    it "does not update the post if the params are invalid" do
      http_login
      post = create :post, title: "Old title"
      patch :update, id: post.id, post: { title: nil }

      expect(Post.find(post.id).title).to eq "Old title"
      expect(subject).to render_template :edit
      expect(subject).to set_the_flash[:alert]
    end

    it "requires authentication" do
      post = create :post
      patch :update, id: post.id, post: { title: "new title" }
      expect(subject.status).to eq 401
    end
  end

  describe "#destroy" do
    it "requires authentication" do
      delete :destroy, id: 1
      expect(response.status).to eq 401
    end

    it "deletes a post" do
      http_login
      post = create :post
      expect do
        delete :destroy, id: post.id
      end.to change { Post.count }.by -1

      expect(subject).to redirect_to admin_path
    end

    it "does not blow up if the post ins't found" do
      http_login
      delete :destroy, id: 1
      expect(subject).to redirect_to admin_path
    end
  end
end
