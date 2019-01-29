require 'rails_helper'

RSpec.describe UserIp, type: :model do
  it { should have_many :posts}
  it { should have_many :users}

  describe ".user_ips_with_users" do

    context "We have some posts by users from the same IP" do
      let!(:user1){ create(:user) }
      let!(:user2){ create(:user, username: "John") }
      let!(:user_ip) {create :user_ip}
      let!(:post1){ create(:post, user: user1, user_ip: user_ip) }
      let!(:post2){ create(:post, user: user2, user_ip: user_ip) }

      it 'returned must contain ip-address' do
        expect(UserIp.user_ips_with_users[0][:ip]).to eql user_ip.ip
      end

      it 'returned array must contain usernames' do
        expect(UserIp.user_ips_with_users[0][:usernames].include?(user1.username)).to be true
      end


    end

    context "We do not have posts by users from the same IP" do
      let!(:user1){ create(:user) }
      let!(:user2){ create(:user, username: "John") }
      let!(:user_ip) {create :user_ip}
      let!(:user_ip2) {create :user_ip}
      let!(:post1){ create(:post, user: user1, user_ip: user_ip) }
      let!(:post2){ create(:post, user: user2, user_ip: user_ip2) }

      it 'returned empty array' do
        expect(UserIp.user_ips_with_users.empty?).to be true
      end
    end

  end
end
