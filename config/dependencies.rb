service :markdown_parser do |_container|
  MarkdownParser.new(
    Redcarpet::Markdown,
    HtmlAndCodeRenderer.new(
      filter_html: true,
      hard_wrap: true,
    ),
  )
end

factory :observed_post do |container, post, is_draft, tags|
  ObservableRecord.new(
    post,
    CompositeObserver.new([
      PublishObserver.new(is_draft: is_draft),
      ParseMarkdownObserver.new(container[:markdown_parser]),
      TaggingObserver.new(tags),
    ]),
  )
end

factory :saveable_post do |container, post, is_draft, tags|
  container[:observed_post].new(
    PostWithSlug.new(post, container[:builds_unique_slug]),
    is_draft,
    tags,
  )
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
    PostWithPrettyDate,
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
