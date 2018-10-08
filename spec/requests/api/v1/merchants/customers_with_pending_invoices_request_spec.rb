require 'rails_helper'
# GET /api/v1/merchants/:id/customers_with_pending_invoices
# returns a collection of customers which have pending (unpaid) invoices.
# A pending invoice has no transactions with a result of success.

describe "Merchant API customers with pending invoices" do
  it 'returns a list of customers with unpaid invoices for a merchant' do
    merchant = create(:merchant)

    success_customers = create_list(:customer, 2)
    success_invoices = success_customers.map do |customer|
      create(:invoice, customer: customer, merchant: merchant)
    end
    success_transactions = success_invoices.map do |invoice|
      create(:transaction, invoice: invoice, result: "success")
    end

    failed_customers = create_list(:customer, 3)
    failed_invoices = failed_customers.map do |customer|
      create(:invoice, customer: customer, merchant: merchant)
    end
    failed_transactions = failed_invoices.map do |invoice|
      create(:transaction, invoice: invoice, result: "failed")
    end

    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

    customers = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customers.class).to eq(Array)
    expect(customers.count).to eq(3)
  end
end
