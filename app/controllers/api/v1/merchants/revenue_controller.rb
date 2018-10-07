class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    merchant = Merchant.revenue_on_date(params[:date], params[:id])

    render json: {  "total_revenue": merchant.revenue }
  end
end
