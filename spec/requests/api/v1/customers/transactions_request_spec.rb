require 'rails_helper'

describe 'Customer transactions API' do
  it 'sends a list of transactions for a customer' do
    customer_id = create(:customer).id
    invoices = create_list(:invoice, 3, customer_id: customer_id)
    transaction_1, transaction_2, transaction_3 = invoices.map do |invoice|
      create(:transaction, invoice_id: invoice.id)
    end

    get "/api/v1/customers/#{customer_id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions.count).to eq(3)
    expect(transactions.class).to eq(Array)
    expect(transactions[0]["id"]).to eq(transaction_1.id)
    expect(transactions[1]["id"]).to eq(transaction_2.id)
    expect(transactions[2]["id"]).to eq(transaction_3.id)
  end
end
