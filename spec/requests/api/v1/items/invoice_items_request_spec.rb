require 'rails_helper'

describe 'Item InvoiceItems API' do
  it 'returns a list of invoice items for an item' do
    id = create(:item).id
    create_list(:invoice_item, 4, item_id: id)

    get "/api/v1/items/#{id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items.count).to eq(4)
    expect(invoice_items.class).to eq(Array)
    expect(invoice_items[0]["item_id"]).to eq(id)
    expect(invoice_items[1]["item_id"]).to eq(id)
    expect(invoice_items[2]["item_id"]).to eq(id)
    expect(invoice_items[3]["item_id"]).to eq(id)
  end
end
