module Posts
  class UserFinder
    include Interactor

    def call
      user = User.find_or_create_by(username: context.username)
      context.user = user if user
    end
  end
end
