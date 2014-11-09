class PublishObserver
  def initialize(is_draft:)
    @is_draft = is_draft
  end

  def saved(post)
    if post_should_be_published(post)
      publish_post(post)
    end
  end

  alias_method :updated, :saved

  private

  def post_should_be_published(post)
    !@is_draft && post.published_at.nil?
  end

  def publish_post(post)
    post.published_at = Time.now
  end
end
