module Rates
  class Create < BaseInteractor

    def call
      @post = context.post
      rate = @post.rates.build(rate: context.rate)
      begin
        if rate.save
          update_rating!(rate.rate)
          context.rating = @post.rating
        else
          context.fail!
        end
      rescue ActiveRecord::NotNullViolation
        context.fail!
      end
    end

    def update_rating!(rate)
      # add calculation rating without Rates table
      rates_counter = @post.rates_counter
      new_rates_counter = rates_counter + 1
      @new_rating = (( @post.rating * rates_counter) + rate) / new_rates_counter
      begin
        @post.update(rating: @new_rating.round(2), rates_counter: new_rates_counter)
      rescue ActiveRecord::StaleObjectError
        @post.reload
        @post.update(rating: @new_rating.round(2), rates_counter: new_rates_counter)
      end
    end
  end
end
