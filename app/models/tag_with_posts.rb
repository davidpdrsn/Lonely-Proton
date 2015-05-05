class TagWithPosts < SimpleDelegator
  def initialize(tag, posts_collection_decorator)
    super(tag)
    @tag = tag
    @posts_collection_decorator = posts_collection_decorator
  end

  def posts
    @posts_collection_decorator.new(@tag.posts)
  end
end
