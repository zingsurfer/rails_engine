class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: Item.find_by(item_params)
  end

  def index
    render json: Item.where(item_params)
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :created_at, :updated_at)
  end
end
