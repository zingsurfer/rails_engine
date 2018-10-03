class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: Merchant.search(params)
  end
end
