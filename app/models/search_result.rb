class SearchResult
  def initialize(posts, query)
    @posts = posts
    @query = query
  end

  attr_reader :posts, :query

  def has_posts?
    @posts.present?
  end
end
