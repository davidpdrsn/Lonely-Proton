# Class that searches for records
class Search
  def for(query_param, type:)
    posts = type.where_content_or_title_matches(query_param)
    SearchResult.new(posts, query_param)
  end
end
