module Posts
  class Validator < BaseInteractor
  include Interactor
  include ActiveModel::Validations

  validates_presence_of :title, :body, :username
  validates :ip, ip: true

    def call

    end
  end
end
