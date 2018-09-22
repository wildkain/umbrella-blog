require 'rails_helper'

describe Posts::Create do
  let(:user) { create (:user, username: "David") }
  let!(:context) { { post: attributes_for(:post), user: user}  }

  it 'returns intance of Post' do
    interactor = Posts::Create.call(context)
    expect(interactor).to be_success
  end
end
