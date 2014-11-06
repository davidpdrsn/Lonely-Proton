class ArchivesController < ApplicationController
  def index
    @posts = DecoratedCollection.new(
      Post.recently_published_first,
      PostWithPrettyDate
    )
  end
end
