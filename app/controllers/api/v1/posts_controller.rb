class Api::V1::PostsController < ApplicationController

  def create
   # user = User.find_or_create_by(username: params[:post][:username])

    result = Posts::Handler.call(post_params)

     if result.success? && result.post.save
       render json: result.post
     else
      render status: :unprocessable_entity, message: "#{result.error}"
     end
  end


  private

  def validate_params
    puts params
  end
  def post_params
    params.require(:post).permit(:title, :body, :username, :ip)
  end

end