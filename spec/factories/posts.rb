FactoryBot.define do
  factory :post do
    title { "MyString" }
    body { "MyText" }
    user
    user_ip
  end

  factory :invalid_post, class: Post do
    body { "MyText" }
  end
end
