require 'rails_helper'
#GET /api/v1/merchants/:id/favorite_customer
#returns the customer who has conducted the most total number of successful transactions.
describe 'Merchants API favorite customer' do
  it 'sends the customer with the most succesful transactions for a merchant' do
    merchant = create(:merchant)
    customers = create_list(:customer, 3)
    favorite_customer = create(:customer)

    invoices = customers.map do |customer|
      create(:invoice, customer: customer, merchant: merchant)
    end

    favorite_invoice = create(:invoice, customer: favorite_customer, merchant: merchant)

    transactions = invoices.map do |invoice|
      create(:transaction, invoice: invoice, result: "success")
    end

    favorite_transactions = create_list(:transaction, 5, invoice: favorite_invoice, result: "success")

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(favorite_customer.id)
  end
end
