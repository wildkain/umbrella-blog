require 'rails_helper'

describe Posts::Create do
  let!(:user) { create(:user, username: "David") }
  let!(:user_ip) {create :user_ip}
  let!(:params) { { post: attributes_for(:post).merge!(user: user, ip: user_ip)} }
  let!(:invalid_params) { { post: attributes_for(:invalid_post).merge!(user: user) }}

  context "with VALID params" do
    before { @interactor = Posts::Create.call(params[:post])}

    it 'should be successfull' do
      expect(@interactor).to be_success
    end

    it 'returns new post in context' do
      expect(@interactor.post).to be_kind_of(Post)
    end

    it 'creates a new post' do
      expect{ Posts::Create.call(params[:post])}.to change(Post, :count).by(1)
    end
  end

  context "with INVALID params" do
    before { @interactor = Posts::Create.call(invalid_params[:post])}

    it 'should not be successfull' do
      expect(@interactor).to_not be_success
    end

    it 'not create Post count' do
      expect{ Posts::Create.call(invalid_params[:post])}.to_not change(Post, :count)
    end

  end

end
