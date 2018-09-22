class BaseInteractor
  include Interactor
  include ActiveModel::Validations

  # For any class that inherits this class, a `before` hook is registered, which raises context.fail!
  # if the reqired parameters are not passed in during invocation.
  def self.inherited(subclass)
    subclass.class_eval do

      before do
        unless self.valid?
          self.context.fail!(error: self.errors.full_messages.to_sentence)
        end
      end

      def read_attribute_for_validation(key)
        self.context.send(key.to_sym)
      end
    end
  end
end