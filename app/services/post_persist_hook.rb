class PostPersistHook < SimpleDelegator
  def initialize(post)
    @post = post
    super(post)
  end

  def save
    fail "PostPersistHook subclass must implement #save"
  end

  def update(params)
    @post.update(params).tap { |updated| save if updated }
  end
end
