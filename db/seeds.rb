require 'faker'
10.times do
  User.create(username: Faker::Internet.username )
end
100.times do
  Posts::Handler.call(title: Faker::Lorem.sentence(10),
                      body:  Faker::Lorem.sentence(100),
                      username: User.find(rand(1..10)).username,
                      ip: "192.168.0.#{rand(0..50)}"
                      )
end