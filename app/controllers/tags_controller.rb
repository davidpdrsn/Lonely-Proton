# Controller responsible for crud actions related to tags
# It also lets you create tags over HTTP
class TagsController < ApplicationController
  before_filter :require_authentication, only: [:create]

  def index
    @tags = Tag.tags_with_posts
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def create
    tag = Tag.new(tag_params)

    if tag.save
      render json: tag.to_json, status: :created
    else
      render json: { errors: tag.errors.to_json }, status: :unprocessable_entity
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
