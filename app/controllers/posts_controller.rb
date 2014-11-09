class PostsController < ApplicationController
  before_action :require_authentication, only: [:create, :new, :edit,
                                                :update, :destroy]

  def index
    @posts = DecoratedCollection.new(Post.recently_published_first, decorator)
  end

  def show
    @post = decorator.decorate(Post.find(params[:id]))

    if @post.draft?
      require_authentication
    end
  end

  def new
    post = Post.new
    @form = NewPostForm.new(post, all_tags)
  end

  def create
    new_post = Post.new(post_params)
    new_post.slug = BuildsUniqueSlug.new(Post.all, new_post).unique_slug

    observer = CompositeObserver.new([
      PublishObserver.new(is_draft: params[:draft]),
      ParseMarkdownObserver.new(MarkdownParser.new),
      TaggingObserver.new(Tag.find_for_ids(params[:post][:tag_ids]))
    ])

    @post = ObservableRecord.new(new_post, observer)

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
    post_to_edit = Post.find(params[:id])

    observer = CompositeObserver.new([
      PublishObserver.new(is_draft: params[:draft]),
      ParseMarkdownObserver.new(MarkdownParser.new),
      TaggingObserver.new(Tag.find_for_ids(params[:post][:tag_ids]))
    ])

    @post = ObservableRecord.new(post_to_edit, observer)

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
