class Api::V1::Merchants::InvoicesController < ApplicationController
  def index
    render json: Merchant.find(params[:id]).invoices
  end
end
