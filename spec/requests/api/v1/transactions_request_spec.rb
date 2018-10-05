require 'rails_helper'

describe 'Transactions API' do
  it 'sends a list of transactions' do
    create_list(:transaction, 4)

    get "/api/v1/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions.class).to be(Array)
    expect(transactions.count).to eq(4)
  end
  it 'sends a single transaction' do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction.class).to eq(Hash)
    expect(transaction["id"]).to eq(id)
  end
end
