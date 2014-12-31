require "rails_helper"

describe PostsController do
  describe "#index" do
    it "delegates to .recently_published_first for finding the posts" do
      collection = stub_service :post_collection
      allow(collection).to receive(:new)

      allow(Post).to receive(:recently_published_first)
      get :index
      expect(Post).to have_received(:recently_published_first)
    end
  end

  describe "#show" do
    it "shows the post" do
      post = create :post
      decorator = stub_service :post_decorator
      allow(decorator).to receive(:new).and_return(post)

      get :show, id: post.id
      expect(response.status).to eq 200
    end

    it "requires authentication if the post is a draft" do
      draft = create :post, published_at: nil
      decorator = stub_service :post_decorator
      allow(decorator).to receive(:new).and_return(draft)

      get :show, id: draft.id
      expect(response.status).to eq 401
    end

    it "lets authorized users see drafts" do
      http_login
      draft = create :post, published_at: nil
      decorator = stub_service :post_decorator
      allow(decorator).to receive(:new).and_return(draft)

      get :show, id: draft.id
      expect(response.status).to eq 200
    end
  end

  describe "#create" do
    it "requires authentication" do
      post :create, post: { title: "title", markdown: "markdown" }
      expect(response.status).to eq 401
    end

    it "creates the post if its valid" do
      http_login
      a_post = build_saveable_post(valid: true)

      post :create, post: attributes_for(:post)

      expect(controller).to set_the_flash[:notice]
      expect(controller).to redirect_to(a_post)
    end

    it "does not create the post if its invalid" do
      http_login
      build_saveable_post(valid: false)

      post :create, post: attributes_for(:post)

      expect(controller).to set_the_flash[:alert]
      expect(controller).to render_template(:new)
    end

    def build_saveable_post(valid:)
      a_post = build_stubbed(:post)
      saveable_post = stub_factory(:saveable_post)
      allow(saveable_post).to receive(:new).and_return(a_post)
      allow(a_post).to receive(:save).and_return(valid)
      a_post
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
      params = { title: "hi there" }
      post = build_saveable_post(params: params, valid: true)

      patch :update, id: post.id, post: params

      expect(post).to have_received(:update).with(params)
      expect(controller).to set_the_flash[:notice]
      expect(controller).to redirect_to(post)
    end

    it "does not update the post if the params are invalid" do
      http_login
      params = { title: "hi there" }
      post = build_saveable_post(params: params, valid: false)

      patch :update, id: post.id, post: params

      expect(post).to have_received(:update).with(params)
      expect(controller).to set_the_flash[:alert]
      expect(controller).to render_template(:edit)
    end

    it "requires authentication" do
      post = create :post
      patch :update, id: post.id, post: { title: "new title" }
      expect(subject.status).to eq 401
    end

    def build_saveable_post(params:, valid:)
      post = create :post
      allow(post).to receive(:update).with(params).and_return(valid)
      saveable_post = stub_factory(:saveable_post)
      allow(saveable_post).to receive(:new).and_return(post)
      post
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
      end.to change { Post.count }.by(-1)

      expect(subject).to redirect_to admin_path
    end

    it "does not blow up if the post ins't found" do
      http_login
      delete :destroy, id: 1
      expect(subject).to redirect_to admin_path
    end
  end

  def create_post(valid:)
    a_post = build_stubbed(:post)
    allow(Post).to receive(:new).and_return(a_post)
    allow(a_post).to receive(:save).and_return(valid)

    post_decorator = stub_service(:post_decorator)
    allow(post_decorator).to receive(:new).and_return(a_post)

    a_post
  end
end
