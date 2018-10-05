class Api::V1::Merchants::MerchantInvoicesController < ApplicationController
  def index
    render json: Merchant.find(params[:id]).invoices
  end
end
