module Rates
  class Validator < BaseInteractor

    validates_presence_of :post
    validates :rate, numericality: { only_integer: true,
                                     greater_than_or_equal_to: 1,
                                     less_than_or_equal_to: 5 }

    def call

    end

  end
end