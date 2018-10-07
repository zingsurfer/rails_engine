require 'rails_helper'

describe 'Invoice Transactions API' do
  it 'sends a list of transactions for an invoice' do
    create(:transaction) #unrelated_transaction
    invoice_id = create(:invoice).id
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3, invoice_id: invoice_id)

    get "/api/v1/invoices/#{invoice_id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions.class).to eq(Array)
    expect(transactions[0]["invoice_id"]).to eq(invoice_id)
    expect(transactions[1]["invoice_id"]).to eq(invoice_id)
    expect(transactions[2]["invoice_id"]).to eq(invoice_id)
    expect(transactions[0]["id"]).to eq(transaction_1.id)
    expect(transactions[1]["id"]).to eq(transaction_2.id)
    expect(transactions[2]["id"]).to eq(transaction_3.id)
    expect(transactions.count).to eq(3)
  end
end
