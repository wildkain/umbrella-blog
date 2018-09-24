module Rates
  class Create < BaseInteractor

    def call
      @post = context.post
      rate = @post.rates.build(rate: context.rate)
      begin
        if rate.save
          context.rating = updated_rating
        else
          context.fail!
        end
      rescue ActiveRecord::NotNullViolation
        context.fail!
      end
    end

    def updated_rating
      @post.rating
    end
  end
end