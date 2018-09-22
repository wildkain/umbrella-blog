FactoryBot.define do
  factory :post do
    title { "MyString" }
    body { "MyText" }
    username { "David"}
    ip { "MyString" }
  end

  factory :invalid_post, class: Post do
    body { "MyText" }
  end
end
