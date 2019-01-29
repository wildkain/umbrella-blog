class Post < ApplicationRecord
  belongs_to :user
  belongs_to :user_ip
  has_many :rates

  scope :top, ->(count) { includes(:user).order(rating: :desc).limit(count) }
end
