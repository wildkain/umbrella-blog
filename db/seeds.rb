require 'faker'

# create users
100.times do
  Posts::UserFinder.call(username: Faker::Internet.username)
end

# create IPs
50.times do
  Posts::IpSaver.call(ip: Faker::Internet.ip_v4_address)
end

#create post
200000.times do
  Posts::Handler.call(title: Faker::Lorem.sentence(10),
                      body:  Faker::Lorem.sentence(100),
                      username: User.all.sample.username,
                      user_ip: UserIp.all.sample.ip)
end

# First 5 post gets rates
50.times do
  Rates::Handler.call(post: Post.find(rand(1..5)), rate: rand(1..5))
end