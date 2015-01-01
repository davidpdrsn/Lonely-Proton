# Observer that will publish a post if required when saving or updating
class PublishablePost < PostPersistHook
  def initialize(post, is_draft:)
    super(post)
    @post = post
    @is_draft = is_draft
  end

  def save
    publish_post if post_should_be_published
    @post.save
  end

  private

  def post_should_be_published
    !@is_draft && @post.published_at.nil?
  end

  def publish_post
    @post.published_at = Time.now
  end
end
