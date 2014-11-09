class Search
  def for(query_param)
    # TODO: Remove DIP violation
    posts = Post.where_content_or_title_matches(query_param)
    SearchResult.new(posts, query_param)
  end
end
