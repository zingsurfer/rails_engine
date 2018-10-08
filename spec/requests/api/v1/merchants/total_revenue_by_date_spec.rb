require 'rails_helper'
# GET /api/v1/merchants/revenue?date=x
# returns the total revenue for date x across all merchants

describe 'Merchant Revenue API' do
  it 'returns the total revenue for all merchants on a specific invoice date' do
    query_merchants = create_list(:merchant, 3)

    invoice_list = query_merchants.map do |merchant|
      create(:invoice, merchant: merchant, created_at: Time.parse("2018-10-07"))
    end

    invoice_list.map do |invoice|
      create(:invoice_item, quantity: 2, unit_price: 5.00, invoice: invoice)
      create(:transaction, result: "success", invoice: invoice)
    end

    x = "2018-10-07"
    get "/api/v1/merchants/revenue?date=#{x}"

    merchants = JSON.parse(response.body)

    expect(merchants["total_revenue"]).to eq("30.0")
    expect(response).to be_successful
  end
end
