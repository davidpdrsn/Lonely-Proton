class AdminController < ApplicationController
  before_filter :require_authentication

  def index
    @posts = Post.all
  end
end
