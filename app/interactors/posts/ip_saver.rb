module Posts
  class IpSaver
    include Interactor

    def call
      ip = UserIp.new(ip: context.ip)
      if ip.save
        context.ip = ip
      else
        context.fail!
      end
    end
  end
end