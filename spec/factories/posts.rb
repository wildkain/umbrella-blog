FactoryBot.define do
  factory :post do
    title { "MyString" }
    body { "MyText" }
    user
    ip { "MyString" }
  end

  factory :invalid_post, class: Post do
    body { "MyText" }
  end
end
