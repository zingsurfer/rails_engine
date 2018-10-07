class Api::V1::Transactions::InvoiceController < ApplicationController
  def show
    render json: Transaction.find(params[:id]).invoice
  end
end
