module Admin
  class PostsController < AdminController
    def create
      post_params = params.require(:post).permit(:title, :markdown, :link)
      post = dependencies[:saveable_post].new(params).new(Post.new(post_params))

      if post.save
        render json: post
      else
        render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
