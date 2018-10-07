require 'rails_helper'

describe 'Invoice Item Invoice API' do
  it 'sends the associated invoice for an invoice_item' do
    create(:invoice) #unrelated invoice
    invoice_id = create(:invoice).id
    invoice_item_id = create(:invoice_item, invoice_id: invoice_id).id
    get "/api/v1/invoice_items/#{invoice_item_id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice.class).to eq(Hash)
    expect(invoice["id"]).to eq(invoice_id)
    expect(invoice["merchant_id"]).to eq(Invoice.last.merchant_id)
  end
end
