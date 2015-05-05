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
    if updated
      save
    end
    updated
  end
end
