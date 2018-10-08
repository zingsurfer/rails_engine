class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    merchant = Merchant.revenue_on_date(params[:date], params[:id])

    render json: {  "revenue": merchant.revenue }
  end

  def index
    merchants = Merchant.total_revenue(params[:date])

    render json: { "total_revenue": merchants[0].revenue }
  end
end
