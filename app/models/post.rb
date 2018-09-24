class Post < ApplicationRecord
  belongs_to :user
  has_many :rates

  scope :top, ->(count) { includes(:user).order(rating: :desc).limit(count) }
end
