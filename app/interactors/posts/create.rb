module Posts
  class Create
    include Interactor

    def call
      user = context.user
      post = user.posts.build(title: context.title, body: context.body, user_id: user.id, ip: context.ip)
      context.post = post
    end
  end
end