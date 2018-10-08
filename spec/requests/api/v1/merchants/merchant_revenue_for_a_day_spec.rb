require 'rails_helper'
# GET /api/v1/merchants/:id/revenue?date=x
# returns the total revenue for that merchant for a specific invoice date x
describe 'Merchant Revenue API' do
  it 'returns the total revenue for a merchant on a specific invoice date' do
    query_merchant = create(:merchant)
    invoice_list = create_list(:invoice, 3, merchant: query_merchant, created_at: Time.parse("2018-10-07"))
    invoice_list.map do |invoice|
      create(:invoice_item, quantity: 2, unit_price: 5.00, invoice: invoice)
      create(:transaction, result: "success", invoice: invoice)
    end
    x = "2018-10-07"
    get "/api/v1/merchants/#{query_merchant.id}/revenue?date=#{x}"

    merchant = JSON.parse(response.body)

    expect(merchant["revenue"]).to eq("30.0")
    expect(response).to be_successful
  end
end
