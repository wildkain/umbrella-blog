require 'rails_helper'

describe Rates::Validator do
  let!(:user) { create :user}
  let!(:user_ip) {create :user_ip}
  let!(:post){ create(:post, user: user, user_ip: user_ip) }
  let!(:params) { { rate: 5, post: post } }
  let!(:invalid_params){ { rate: nil, post: post } }

  context "with valid stack of attributes" do

    it ".call be successfull" do
      interactor = Rates::Validator.call(params)

      expect(interactor).to be_success
    end
  end

  context "with invalid attrs" do

    before do
      @interactor = Rates::Validator.call(invalid_params)
    end

    it 'fails with invalid(missed) attrs' do
      expect(@interactor).to_not be_success
    end

    it 'return context validation error' do
      expect(@interactor.error).to eq "Rate is not a number"
    end
  end
end
