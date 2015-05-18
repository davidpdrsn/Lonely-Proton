class PostPersistHook < SimpleDelegator
  def initialize(post)
    @post = post
    super(post)
  end

  def save
    fail "PostPersistHook subclass must implement #save"
  end

  def update(params)
    updated = @post.update(params)
    save if updated
    updated
  end
end
