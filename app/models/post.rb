class Post < ApplicationRecord
  belongs_to :user
  has_many :rates

  def rating
    rates.sum(:rate)
  end
end
