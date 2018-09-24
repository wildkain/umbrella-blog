class Api::V1::RatesController < Api::V1::BaseController
  before_action :find_post, only: :create

  def create
    handler = Rates::Handler.call(rate_params.merge!(post: @post))
    if handler.success?
      render json: { post: @post.id, rating: handler.rating }
    else
      render status: :unprocessable_entity
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def rate_params
    params.permit(:rate, :post_id)
  end
end
