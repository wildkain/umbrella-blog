require 'rails_helper'

describe 'Posts API' do

  describe "POST #create" do
    let(:user){ create(:user) }
    let!(:valid_params) do
      { action: :create, format: :json,
        post: attributes_for(:post).merge!(username: user.username)}
    end
    let(:invalid_params) {{ action: :create, format: :json, post:{ body: "body", title: nil, username: nil} }}

    context "with valid attributes" do
      it 'saves a new post in database' do
        expect { post "/api/v1/posts", params: valid_params }.to change(Post, :count).by(1)
        expect(Post.last.user.username).to eq valid_params[:post][:username]
      end
    end

    context "with missed attributes" do
     it 'returns 422 status' do
       post "/api/v1/posts", params: invalid_params
       expect(response.status).to eq 422
     end

     it 'shall not pass with missed attrs ' do
       expect { post "/api/v1/posts", params: invalid_params }.to_not change(Post, :count)
     end
    end
  end

end