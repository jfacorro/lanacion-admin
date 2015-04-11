class ApiApnsTokensController < ApplicationController
  protect_from_forgery

  def create
    puts params
    apns_token = ApnsToken.find_or_create_by(device_id: params[:device_id], apns_token: params[:apns_token])
    render json: apns_token
  end
end
