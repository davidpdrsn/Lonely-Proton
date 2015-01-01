# Class that builds a unique slug for a post
class BuildsUniqueSlug
  def unique_slug(post, all_posts)
    @post = post
    @all_posts = all_posts

    if slug_has_been_taken
      build_new_slug
    else
      current_slug
    end
  end

  private

  attr_reader :post, :all_posts

  def slug_has_been_taken
    all_posts.find_by(slug: current_slug).present?
  end

  def build_new_slug
    @iteration = (@iteration || 0) + 1
    unique_slug(post, all_posts)
  end

  def current_slug
    build_slug
  end

  def build_slug
    [post.title, @iteration]
      .compact
      .map(&:to_s)
      .map(&:parameterize)
      .join("-")
  end
end
