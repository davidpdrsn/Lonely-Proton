# Class that builds a unique slug for a post
class BuildsUniqueSlug
  pattr_initialize :posts, :post

  def unique_slug
    if slug_has_been_taken
      build_new_slug
    else
      current_slug
    end
  end

  private

  def slug_has_been_taken
    @posts.find_by(slug: current_slug).present?
  end

  def build_new_slug
    @iteration = (@iteration || 0) + 1
    unique_slug
  end

  def current_slug
    build_slug
  end

  def build_slug
    [@post.title, @iteration]
      .compact
      .map(&:to_s)
      .map(&:parameterize)
      .join("-")
  end
end
