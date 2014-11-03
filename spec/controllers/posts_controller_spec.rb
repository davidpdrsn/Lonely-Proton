require 'rails_helper'

describe PostsController do
  describe '#create' do
    it 'requires authentication' do
      post :create, post: { title: "title", markdown: "markdown" }
      expect(response.status).to eq 401
    end

    it 'creates the post if its valid' do
      http_login

      expect do
        post :create, post: { title: "title", markdown: "markdown" }
      end.to change { Post.count }.by 1

      expect(subject).to redirect_to Post.last
    end

    it 'does not create the post if its invalid' do
      http_login

      expect do
        post :create, post: { title: nil, markdown: "markdown" }
      end.not_to change { Post.count }

      expect(subject).to set_the_flash[:alert]
      expect(subject).to render_template :new
    end
  end

  describe '#new' do
    it 'requires authentication' do
      get :new
      expect(response.status).to eq 401
    end
  end

  describe '#edit' do
    it 'requires authentication' do
      get :edit, id: 1
      expect(response.status).to eq 401
    end
  end

  describe '#update' do
    it 'updates the post' do
      http_login
      post = create :post, title: "Old title"
      patch :update, id: post.id, post: { title: "New title" }

      expect(Post.find(post.id).title).to eq "New title"
      expect(subject).to set_the_flash[:notice]
    end

    it 'does not update the post if the params are invalid' do
      http_login
      post = create :post, title: "Old title"
      patch :update, id: post.id, post: { title: nil }

      expect(Post.find(post.id).title).to eq "Old title"
      expect(subject).to render_template :edit
      expect(subject).to set_the_flash[:alert]
    end

    it 'requires authentication' do
      post = create :post
      patch :update, id: post.id, post: { title: 'new title' }
      expect(subject.status).to eq 401
    end
  end
end
