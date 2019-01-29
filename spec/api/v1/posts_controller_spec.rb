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

  describe "GET avi/v1/posts/top" do
    let!(:user){ create(:user) }
    let!(:posts) { create_list(:post, 3, user: user )}
    let!(:alone_post) { posts.first }
    let(:first_rate) { create(:rate) }

    before { get '/api/v1/posts/top', params: { format: :json, quantity: 2 }}

    it 'must be success' do
      expect(response.status).to eq 200
    end

    it 'returns post collection' do
      expect(response.body).to have_json_size(2)
    end

    %w[title body].each do |attr|
      it "each post object in collection contain #{attr}" do
        expect(response.body).to be_json_eql(alone_post.send(attr.to_sym).to_json).at_path("0/#{attr}")
      end
    end


  end

end