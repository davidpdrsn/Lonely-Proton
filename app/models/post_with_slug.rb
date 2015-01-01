class PostWithSlug < PostPersistHook
  def initialize(post, slug_builder_factory, all_posts)
    @post = post
    @slug_builder_factory = slug_builder_factory
    @all_posts = all_posts
    super(post)
  end

  def save
    @post.slug = @slug_builder_factory.unique_slug(@post, @all_posts)
    @post.save
  end
end
