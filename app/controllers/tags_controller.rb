class TagsController < ApplicationController
  before_filter :require_authentication, only: [:create]

  def index
    @tags = Tag.all
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
