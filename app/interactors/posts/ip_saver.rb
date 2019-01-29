module Posts
  class IpSaver
    include Interactor

    def call
      ip = UserIp.find_or_create_by(ip: context.ip)
      if ip
        context.ip = ip
      else
        context.fail!
      end
    end
  end
end
