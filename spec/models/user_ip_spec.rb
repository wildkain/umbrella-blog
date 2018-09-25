require 'rails_helper'

RSpec.describe UserIp, type: :model do
  it { should have_many :posts}
  it { should have_many :users}
end
