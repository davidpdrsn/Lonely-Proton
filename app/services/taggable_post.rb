class TaggablePost < PostPersistHook
  def initialize(post, tags)
    super(post)
    @post = post
    @tags = tags
  end

  def save
    @post.tags = @tags
    @post.save
  end
end
