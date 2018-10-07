require 'rails_helper'

describe 'Transaction Invoice API' do
  it 'returns the associated invoice for a transaction' do
    create(:invoice) #unrelated invoice
    invoice_id = create(:invoice).id
    transaction_id = create(:transaction, invoice_id: invoice_id).id

    get "/api/v1/transactions/#{transaction_id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice.class).to be(Hash)
    expect(invoice["id"]).to eq(invoice_id)
    expect(invoice["merchant_id"]).to eq(Invoice.last.merchant_id)
  end
end
