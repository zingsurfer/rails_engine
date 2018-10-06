require 'rails_helper'

describe 'Merchant Invoices API' do
  it 'sends a list of merchant invoices' do
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant_id: merchant.id)
    create(:invoice) #unrelated invoice

    get "/api/v1/merchants/#{merchant.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices.class).to eq(Array)
    expect(invoices.count).to eq(3)
  end
end
