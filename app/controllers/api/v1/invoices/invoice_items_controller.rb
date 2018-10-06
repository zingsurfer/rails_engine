class Api::V1::Invoices::InvoiceItemsController < ApplicationController
  def index
    render json: Invoice.find(params[:id]).invoice_items
  end
end
