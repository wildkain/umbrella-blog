class UserIp < ApplicationRecord
  has_many :posts
  has_many :users, through: :posts

  scope :ips_with_many_posts, -> do
    ActiveRecord::Base
      .connection
      .execute("SELECT DISTINCT ip,  array_agg(users.username) as usernames
    FROM posts
    INNER JOIN user_ips ON posts.user_ip_id = user_ips.id
    INNER JOIN users ON posts.user_id = users.id
    GROUP BY user_ip_id, user_ips.ip
    HAVING COUNT(posts.id) > 1").values.to_h
  end

  # sanitize scope output and serealize
  def self.user_ips_with_users
    ips = []
    ips_with_many_posts.map do |k, v|
      ips << { ip: k, usernames: v.delete('{}').split(',').uniq }
    end
    ips
  end
end
