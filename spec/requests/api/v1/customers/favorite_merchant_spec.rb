require 'rails_helper'
# GET /api/v1/customers/:id/favorite_merchant
# returns a merchant where the customer has conducted the most successful transactions
describe 'Favorite Merchant API' do
  it 'sends a single merchant where the customer has the most successful transactions' do
    merchants_list = create_list(:merchant, 3)
    favorite_merchant = create(:merchant)
    customer = create(:customer)

    invoices = merchants_list.map do |merchant|
      create(:invoice, merchant: merchant, customer: customer)
    end

    favorite_invoice = create(:invoice, merchant: favorite_merchant, customer: customer)

    transactions = invoices.map do |invoice|
      create(:transaction, invoice: invoice, result: "success")
    end

    favorite_transactions = create_list(:transaction, 3, invoice: favorite_invoice, result: "success")

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(favorite_merchant.id)
  end
end
