class BuildsSlugObserver
  def initialize(slug_builder)
    @slug_builder = slug_builder
  end

  def saved(post)
    post.slug = @slug_builder.unique_slug
    post.save
  end

  def updated(post)
    # nop
  end
end
