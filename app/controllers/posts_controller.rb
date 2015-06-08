# Controller responsible for crud actions related to posts
class PostsController < ApplicationController
  before_action :require_authentication, only: [:create, :new, :edit,
                                                :update, :destroy]

  def index
    current_page = params.fetch(:page) { 1 }.to_i

    @posts = dependencies[:paginated_collection].new(
      dependencies[:post_collection].new(
        Post.recently_published_first,
      ),
      page: current_page,
    )
  end

  def show
    @post = dependencies[:post_page].find(params[:id])

    require_authentication if @post.draft?
  end

  def new
    @form = new_post_form(Post.new)
  end

  def create
    @form = new_post_form(saveable_post(Post.new(post_params)))

    if @form.save
      flash.notice = "Post created"
      redirect_to @form.post
    else
      flash.alert = "Post not saved"
      render :new
    end
  end

  def edit
    @form = new_post_form(Post.find(params[:id]))
  end

  def update
    @post = saveable_post(Post.find(params[:id]))

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

  def saveable_post(post)
    dependencies[:saveable_post].new(params).new(post)
  end

  def post_params
    params.require(:post).permit :title, :markdown, :link
  end

  def new_post_form(post)
    dependencies[:new_post_form].new(post, Tag.all)
  end
end
