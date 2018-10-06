class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    render json: Merchant.find(params[:id]).items
  end
end
