# Controller responsible for crud actions related to posts
class PostsController < ApplicationController
  before_action :require_authentication, only: [:create, :new, :edit,
                                                :update, :destroy]

  def index
    @posts = DecoratedCollection.new(
      Post.recently_published_first,
      PostWithPrettyDate,
    )
  end

  def show
    @post = PostWithPrettyDate.new(Post.find(params[:id]))

    require_authentication if @post.draft?
  end

  def new
    @form = new_post_form(Post.new)
  end

  def create
    new_post = Post.new(post_params)
    new_post.slug = BuildsUniqueSlug.new(Post.all, new_post).unique_slug

    @post = make_post_observable(new_post)

    if @post.save
      flash.notice = "Post created"
      redirect_to @post
    else
      flash.alert = "Post not saved"
      render :new
    end
  end

  def edit
    @form = new_post_form(Post.find(params[:id]))
  end

  def update
    @post = make_post_observable(Post.find(params[:id]))

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

  def make_post_observable(post)
    ObservableRecord.new(
      post,
      CompositeObserver.new([
        PublishObserver.new(is_draft: params[:draft]),
        ParseMarkdownObserver.new(MarkdownParser.new),
        TaggingObserver.new(Tag.find_for_ids(params[:post][:tag_ids])),
      ]),
    )
  end

  def post_params
    params.require(:post).permit :title, :markdown, :link
  end

  def new_post_form(post)
    NewPostForm.new(
      post,
      DecoratedCollection.new(Tag.all, TagWithDomId),
    )
  end
end
