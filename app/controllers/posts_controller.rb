class PostsController < ApplicationController
  before_filter :require_authentication, only: [:create, :new, :edit, :update]

  def index
    @posts = DecoratedCollection.new(Post.all, decorator)
  end

  def show
    @post = decorator.decorate(Post.find(params[:id]))
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash.notice = "Post created"
      redirect_to @post
    else
      flash.alert = "Post not saved"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash.notice = "Post updated"
      redirect_to @post
    else
      flash.alert = "Post not updated"
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :markdown)
  end

  def decorator
    CompositeDecorator.new([PostWithPrettyDate])
  end
end
