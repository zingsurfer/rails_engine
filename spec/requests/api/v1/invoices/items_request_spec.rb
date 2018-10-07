require 'rails_helper'

describe 'Invoice Items API' do
  it 'sends a list of items for an invoice' do
    create(:item) # unrelated item
    merchant_id = create(:merchant).id
    item_1, item_2, item_3 = create_list(:item, 3, merchant_id: merchant_id)
    invoice_id = create(:invoice, merchant_id: merchant_id).id

    [item_1, item_2, item_3].map do |item|
      create(:invoice_item, item_id: item.id, invoice_id: invoice_id)
    end

    get "/api/v1/invoices/#{invoice_id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.class).to eq(Array)
    expect(items.count).to eq(3)
    expect(items[0]["id"]).to eq(item_1.id)
    expect(items[1]["id"]).to eq(item_2.id)
    expect(items[2]["id"]).to eq(item_3.id)
  end
end
