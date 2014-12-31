class PostWithSlug < SimpleDelegator
  def initialize(post, slug_builder_factory)
    @post = post
    @slug_builder_factory = slug_builder_factory
    super(post)
  end

  def save
    post.slug = slug_builder_factory.unique_slug(post)
    post.save
  end

  private

  attr_reader :post, :slug_builder_factory
end
