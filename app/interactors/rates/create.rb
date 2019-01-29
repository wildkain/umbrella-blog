module Rates
  class Create < BaseInteractor

    def call
      @post = context.post
      rate = @post.rates.build(rate: context.rate)
      begin
        if rate.save
          update_rating!
          context.rating = @post.rating
        else
          context.fail!
        end
      rescue ActiveRecord::NotNullViolation
        context.fail!
      end
    end

    def update_rating!
      @rating = Rate.where(post: @post).average(:rate)
      @post.transaction do
        @post.update(rating: @rating.round(2, :up))
      end
    end
  end
end
