# Class that builds a unique slug for a post
class BuildsUniqueSlug
  def unique_slug(post)
    if slug_has_been_taken(post)
      build_new_slug(post)
    else
      current_slug(post)
    end
  end

  private

  def slug_has_been_taken(post)
    post.class.find_by(slug: current_slug(post)).present?
  end

  def build_new_slug(post)
    @iteration = (@iteration || 0) + 1
    unique_slug(post)
  end

  def current_slug(post)
    build_slug(post)
  end

  def build_slug(post)
    [post.title, @iteration]
      .compact
      .map(&:to_s)
      .map(&:parameterize)
      .join("-")
  end
end
