class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :ip, :author, :date

  def author
    object.user.username
  end

  def date
    object.created_at.strftime("%Y-%m-%d %H:%m")
  end
end
