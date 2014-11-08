class Publisher
  def publish(post, is_draft:)
    if is_draft
      post.published_at = nil
    else
      post.published_at ||= Time.now
    end
  end
end
