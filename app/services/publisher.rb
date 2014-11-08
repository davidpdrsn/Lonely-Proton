class Publisher
  def initialize(post)
    @post = post
  end

  def publish(is_draft:)
    if is_draft
      @post.published_at = nil
    else
      @post.published_at ||= Time.now
    end
  end
end
