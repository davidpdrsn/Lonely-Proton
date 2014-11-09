# Controller responsible for searching
class SearchesController < ApplicationController
  def index
    decorator = CompositeDecorator.new([
      PostWithPrettyDate,
      CurriedDecorator.new(
        TruncatedPost,
        markdown_parser: MarkdownParser.new,
        truncate_method: ActionController::Base.helpers.method(:truncate),
        length: 100,
      )
    ])

    @results = DecoratedSearchResult.new(
      Search.new.for(params[:query]),
      decorator,
      decorated_collection_factory: DecoratedCollection
    )
  end
end
