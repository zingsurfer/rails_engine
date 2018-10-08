class Api::V1::Items::BestDayController < ApplicationController
  def show
    best_day = Item.best_sell_day(params[:id])
    render json: { "best_day": best_day[0].date }
  end
end
