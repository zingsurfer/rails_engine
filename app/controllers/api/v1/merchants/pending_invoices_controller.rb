class Api::V1::Merchants::PendingInvoicesController < ApplicationController
  def index
    render json: Customer.pending_invoice_customers(params[:id])
  end
end
