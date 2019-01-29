class ApplicationController < ActionController::API
  respond_to :json

  rescue_from ActiveRecord::RecordNotFound do |e|
    respond_to do |format|
      format.json { render json: { code: 404, errors: e.message }, status: 404 }
    end
  end
end
