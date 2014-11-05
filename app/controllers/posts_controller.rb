class PostsController < ApplicationController
  before_filter :require_authentication, only: [:create, :new, :edit, :update]

  def index
    @posts = DecoratedCollection.new(Post.sorted.published, decorator)
  end

  def show
    @post = decorator.decorate(Post.find(params[:id]))
  end

  def new
    post = Post.new
    @form = NewPostForm.new(post, tags)
  end

  def create
    @post = Post.new(post_params)

    tag_ids = params[:post].fetch(:tag_ids, [])
    associate(records_with_ids: tag_ids, of_type: Tag, with_record: @post)

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
    @form = NewPostForm.new(post, tags)
  end

  def update
    @post = Post.find(params[:id])

    tag_ids = params[:post].fetch(:tag_ids, [])
    associate(records_with_ids: tag_ids, of_type: Tag, with_record: @post)

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
    params.require(:post).permit :title, :markdown, :link, :draft
  end

  def decorator
    CompositeDecorator.new([PostWithPrettyDate])
  end

  def tags
    DecoratedCollection.new(Tag.all, TagWithDomId)
  end

  def associate(records_with_ids:, of_type:, with_record:)
    association_name = of_type.to_s.pluralize.downcase

    with_record.public_send("#{association_name}=", [])

    records_with_ids.each do |id|
      associated_record = of_type.find_or_create_by(id: id.to_i)
      with_record.public_send(association_name) << associated_record
    end
  end
end
