module Posts
  class Validator < BaseInteractor
  include Interactor
  include ActiveModel::Validations

  validates_presence_of :title, :body, :username, :ip

    def call

    end


    private


    def validate_params

    end

  end
end