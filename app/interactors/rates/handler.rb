module Rates
  class Handler
    include Interactor
    include Interactor::Organizer

    organize Validator, Create
  end
end
