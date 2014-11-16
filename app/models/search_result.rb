# Class that encapsulates a search query and the matching posts
class SearchResult
  def initialize(posts, query)
    @posts = posts
    @query = query
  end

  attr_reader :posts, :query

  def posts?
    @posts.present?
  end
end
