module Posts
  class Create
    include Interactor

    def call
      user = context.user
      post = user.posts.build(title: context.title, body: context.body, user_ip: context.ip)
      begin
        if post.save
          context.post = post
        else
          context.fail!
        end
      rescue ActiveRecord::NotNullViolation
        context.fail!
      end
    end
  end
end
