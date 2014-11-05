class ArchivesController < ApplicationController
  def index
    @posts = DecoratedCollection.new(Post.sorted.published, PostWithPrettyDate)
  end
end
