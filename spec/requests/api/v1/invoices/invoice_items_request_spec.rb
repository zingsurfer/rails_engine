require 'rails_helper'

describe 'Invoice InvoiceItems API' do
  it 'sends a list of invoice items for an invoice' do
    create(:invoice_item) #unrelated invoice_item
    invoice_id = create(:invoice).id
    invoice_item_1, invoice_item_2, invoice_item_3 = create_list(:invoice_item, 4, invoice_id: invoice_id)

    get "/api/v1/invoices/#{invoice_id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items.class).to eq(Array)
    expect(invoice_items.count).to eq(4)
    expect(invoice_items[0]["id"]).to eq(invoice_item_1.id)
    expect(invoice_items[1]["id"]).to eq(invoice_item_2.id)
    expect(invoice_items[2]["id"]).to eq(invoice_item_3.id)
    expect(invoice_items[0]["invoice_id"]).to eq(invoice_id)
    expect(invoice_items[1]["invoice_id"]).to eq(invoice_id)
    expect(invoice_items[2]["invoice_id"]).to eq(invoice_id)
  end
end
