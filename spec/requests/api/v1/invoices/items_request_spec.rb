require 'rails_helper'

describe 'Invoice Items API' do
  it 'sends a list of items for an invoice' do
    id = create(:invoice).id
    item_1, item_2, item_3, item_4 = create_list(:invoice_item, 4, invoice_id: id)

    get "/api/v1/invoices/#{id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.class).to eq(Array)
    expect(items.count).to eq(4)
    expect(items[0]["id"]).to eq(item_1.id)
    expect(items[1]["id"]).to eq(item_2.id)
    expect(items[2]["id"]).to eq(item_3.id)
    expect(items[3]["id"]).to eq(item_4.id)
  end
end
