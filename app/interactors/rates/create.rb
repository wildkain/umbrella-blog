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
      @rating = @post.rates.average(:rate)
      #@post.transaction do
      #end
      begin
        @post.update(rating: @rating.round(2, :up))
      rescue ActiveRecord::StaleObjectError
        @post.reload
        @post.update(rating: @rating.round(2, :up))
      end
    end
  end
end
