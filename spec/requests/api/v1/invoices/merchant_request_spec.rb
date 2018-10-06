require 'rails_helper'

describe 'Invoice Merchant API' do
  it 'returns the merchant associated with an invoice' do
    merchant_id = create(:merchant).id
    invoice_id = create(:invoice, merchant_id: merchant_id).id

    get "/api/v1/invoices/#{invoice_id}/merchant"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant.class).to eq(Hash)
    expect(merchant["id"]).to eq(merchant_id)
    expect(merchant["name"]).to eq(Merchant.last.name)
  end
end
