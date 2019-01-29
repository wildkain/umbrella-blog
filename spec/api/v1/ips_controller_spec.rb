require 'rails_helper'

describe 'Ips API' do


  describe "GET avi/v1/ips" do

    context "We have some posts by users from the same IP" do
      let!(:user1){ create(:user) }
      let!(:user2){ create(:user, username: "John") }
      let!(:user_ip) {create :user_ip}
      let!(:post1){ create(:post, user: user1, user_ip: user_ip) }
      let!(:post2){ create(:post, user: user2, user_ip: user_ip) }

      before { get '/api/v1/ips', params: { format: :json }}

      it 'must be success' do
        expect(response.status).to eq 200
      end

      it 'returns a collection of ips and usernames' do
        expect(response.body).to have_json_size(1)
      end

      it "return a json collection" do
        expect(response.body).to be_json_eql(UserIp.user_ips_with_users.to_json)
      end
    end




    context "We do not  have some posts by users from the same IP" do
      let!(:user1){ create(:user) }
      let!(:user2){ create(:user, username: "John") }
      let!(:user_ip) {create :user_ip}
      let!(:user_ip2) {create :user_ip}
      let!(:post1){ create(:post, user: user1, user_ip: user_ip) }
      let!(:post2){ create(:post, user: user2, user_ip: user_ip2) }

      before { get '/api/v1/ips', params: { format: :json }}

      it 'must be success' do
        expect(response.status).to eq 200
      end

      it 'returns an empty collection of ips and usernames' do
        expect(response.body).to have_json_size(0)
      end
    end
  end
end
