require 'faker'

# 100.times do
#   User.create(username: Faker::Internet.username)
# end
#
# 50.times do
#   UserIp.create(ip: Faker::Internet.ip_v4_address)
# end


200000.times do
  Posts::Handler.call(title: Faker::Lorem.sentence(10),
                        body:  Faker::Lorem.sentence(100),
                        username: User.all.sample.username,
                        ip: UserIp.all.sample.ip )
end
