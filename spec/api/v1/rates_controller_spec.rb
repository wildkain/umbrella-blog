require 'rails_helper'

describe 'Rates API' do

  describe "POST #create" do
    let!(:user) { create :user }
    let!(:some_post) { create(:post, user:user ) }
    let!(:valid_params) { { action: :create, format: :json, post_id: some_post.id, rate: 5 } }
    let!(:invalid_params) {{ action: :create, format: :json, post_id: some_post.id, rate: nil } }

    context "with valid attributes" do
      before { post '/api/v1/rates', params: valid_params }
      it 'should be successfull response' do
        expect(response.status).to eq 200
      end

      it 'creates a new rate for post' do
        expect{post '/api/v1/rates', params: valid_params }.to change(Rate, :count).by(1)
      end

      it "returns a valid response with rating and post_id" do
        expect(response.body).to be_json_eql({post: some_post.id, rating: some_post.rating }.to_json)
      end
    end

    context "with missed attributes" do
      it 'returns 422 status' do
        post "/api/v1/rates", params: invalid_params
        expect(response.status).to eq 422
      end

      it 'shall not pass with missed attrs ' do
        expect { post "/api/v1/rates", params: invalid_params }.to_not change(Rate, :count)
      end
    end
  end

end