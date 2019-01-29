class Api::V1::IpsController < ApplicationController

  def index
    @ips = UserIp.user_ips_with_users
    render json: @ips
  end
end