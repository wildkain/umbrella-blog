require 'rails_helper'

describe Posts::Validator do
  let!(:valid_params) { attributes_for(:post).merge!(username: "David") }
  let!(:invalid_params){ attributes_for(:invalid_post) }

  context "with valid stack of attributes" do
    it ".call be successfull" do
      interactor = Posts::Validator.call(valid_params)
      expect(interactor).to be_success
    end
  end

  context "with invalid attrs" do
    it 'fails with invalid(missed) attrs' do
      interactor = Posts::Validator.call(invalid_params)
      expect(interactor).to_not be_success
    end
  end
end
