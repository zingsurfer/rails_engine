require 'rails_helper'

describe 'Transactions API' do
  it 'sends a list of transactions' do
    create_list(:transaction, 4)

    get "/api/v1/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions.class).to be(Array)
    expect(transactions.count).to eq(4)
    expect(transactions.last["id"]).to eq(Transaction.last.id)
  end
  it 'sends a single transaction' do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction.class).to eq(Hash)
    expect(transaction["id"]).to eq(id)
    expect(transaction["invoice_id"]).to eq(Transaction.last.invoice_id)
  end
end
