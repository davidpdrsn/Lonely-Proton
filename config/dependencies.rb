service :markdown_parser do |_container|
  MarkdownParser.new(
    Redcarpet::Markdown,
    HtmlAndCodeRenderer.new(
      filter_html: true,
      hard_wrap: true,
    ),
  )
end

factory :saveable_post do |container, is_draft, tags, all_posts|
  CompositeDecorator.new([
    CurriedDecorator.new(TaggablePost, tags),
    CurriedDecorator.new(
      PostWithSlug,
      container[:builds_unique_slug],
      all_posts,
    ),
    CurriedDecorator.new(PostWithHtml, container[:markdown_parser]),
    CurriedDecorator.new(PublishablePost, is_draft: is_draft),
  ])
end

factory :new_post_form do |_container, post, tags|
  NewPostForm.new(
    post,
    DecoratedCollection.new(tags, TagWithDomId),
  )
end

factory :post_collection do |container, posts|
  DecoratedCollection.new(
    posts,
    container[:post_decorator],
  )
end

service :post_decorator do |_container|
  PostWithPrettyDate
end

service :builds_unique_slug do |_container|
  BuildsUniqueSlug.new
end

service :search_result_decorator do |container|
  CompositeDecorator.new([
    container[:post_decorator],
    CurriedDecorator.new(
      TruncatedPost,
      markdown_parser: container[:markdown_parser],
      truncate_method: ActionController::Base.helpers.method(:truncate),
      length: 100,
    ),
  ])
end

factory :decorated_search_result do |container, posts|
  DecoratedSearchResult.new(
    posts,
    container[:search_result_decorator],
    decorated_collection_factory: DecoratedCollection,
  )
end

factory :admin_dashboard do |_container, published, drafts|
  AdminDashboard.new(
    published: published,
    drafts: drafts,
  )
end

service :search_factory do |_container|
  Search.new
end

service :tag_finder do |container|
  TagFinder.new(Tag, TagWithPosts, container[:post_collection])
end
