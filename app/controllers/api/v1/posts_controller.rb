class Api::V1::PostsController < ApplicationController

  def create
    result = Posts::Handler.call(post_params)

     if result.success?
       render json: result.post
     else
      render status: :unprocessable_entity, message: "#{result.error}"
     end
  end

  def top
    @posts = Post.top(params[:quantity].to_i)
    render json: @posts, each_serializer: PostCollectionSerializer
  end

  private

  def validate_params
    puts params
  end

  def post_params
    params.require(:post).permit(:title, :body, :username, :ip)
  end
end