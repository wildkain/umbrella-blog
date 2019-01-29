module Posts
  class Handler
    include Interactor
    include Interactor::Organizer

    organize Validator, UserFinder, IpSaver,  Create
  end
end
