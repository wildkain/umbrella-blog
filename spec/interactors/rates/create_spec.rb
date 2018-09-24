require 'rails_helper'

describe Rates::Create do
  let!(:user) { create :user}
  let!(:post){ create(:post, user: user) }
  let(:params) { { rate: 5, post: post } }
  let(:invalid_params){ { rate: nil, post: post } }

  context "Try to create with VALID attrs" do
    before { @interactor = Rates::Create.call(params) }

    it 'should be successfull' do
      expect(@interactor).to be_success
    end

    it 'should return new rating of post in context' do
      expect(@interactor.rating).to eq 5
    end

    it 'should increase rating of post' do
      expect(post.rating).to eq 5
    end
  end

  context "Try to create with INVALID attrs" do
    before { @interactor = Rates::Create.call(invalid_params) }

    it 'should NOT be success' do
      expect(@interactor).to_not be_success
    end

    it "should not create a new Rate" do
      expect{@interactor}.to_not change(Rate, :count)
    end

    it "should not change post rating" do
      expect(post.rating).to eq 0
    end
  end

end
