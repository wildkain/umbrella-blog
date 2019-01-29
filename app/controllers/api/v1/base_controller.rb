class Api::V1::BaseController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { code: 404, errors: e.message }, status: 404
  end
end