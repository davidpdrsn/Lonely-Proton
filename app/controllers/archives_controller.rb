# Controller responsible for finding posts and showing the archive
class ArchivesController < ApplicationController
  def index
    @posts = dependencies[:post_collection].new(
      Post.recently_published_first,
    )
  end
end
