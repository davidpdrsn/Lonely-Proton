class PostsController < ApplicationController
  before_filter :require_authentication, only: [:create, :new, :edit,
                                                :update, :destroy]

  def index
    @posts = DecoratedCollection.new(Post.recently_published_first, decorator)
  end

  def show
    @post = decorator.decorate(Post.find(params[:id]))
  end

  def new
    post = Post.new
    @form = NewPostForm.new(post, all_tags)
  end

  def create
    @post = Post.new(post_params)

    Publisher.new(@post).publish(is_draft: params[:draft])

    tags = Tag.find_for_ids(params[:post][:tag_ids])
    @post.update(tags: tags)

    if @post.save
      flash.notice = "Post created"
      redirect_to @post
    else
      flash.alert = "Post not saved"
      render :new
    end
  end

  def edit
    post = Post.find(params[:id])
    @form = NewPostForm.new(post, all_tags)
  end

  def update
    @post = Post.find(params[:id])

    Publisher.new(@post).publish(is_draft: params[:draft])

    tags = Tag.find_for_ids(params[:post][:tag_ids])
    @post.update(tags: tags)

    if @post.update(post_params)
      flash.notice = "Post updated"
      redirect_to @post
    else
      flash.alert = "Post not updated"
      render :edit
    end
  end

  def destroy
    Post.find_by(id: params[:id]).try(:destroy)
    redirect_to admin_path
  end

  private

  def post_params
    params.require(:post).permit :title, :markdown, :link
  end

  def decorator
    CompositeDecorator.new([PostWithPrettyDate])
  end

  def all_tags
    DecoratedCollection.new(Tag.all, TagWithDomId)
  end
end
