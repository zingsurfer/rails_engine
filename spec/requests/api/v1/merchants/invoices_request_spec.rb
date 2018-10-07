require 'rails_helper'

describe 'Merchant Invoices API' do
  it 'sends a list of merchant invoices' do
    create(:invoice) #unrelated invoice
    merchant_id = create(:merchant).id
    invoices = create_list(:invoice, 3, merchant_id: merchant_id)

    get "/api/v1/merchants/#{merchant_id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices.class).to eq(Array)
    expect(invoices.count).to eq(3)
    expect(invoices[0]["merchant_id"]).to eq(merchant_id)
    expect(invoices[1]["merchant_id"]).to eq(merchant_id)
    expect(invoices[2]["merchant_id"]).to eq(merchant_id)
  end
end
