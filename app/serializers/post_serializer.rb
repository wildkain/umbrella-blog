class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :ip, :author, :date

  def author
    object.user.username
  end

  def ip
    object.user_ip.ip
  end

  def date
    object.created_at.strftime("%Y-%m-%d %H:%m")
  end
end
