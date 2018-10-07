require 'rails_helper'

describe 'Invoice Item Item API' do
  it 'sends the associated item for an invoice_item' do
    create(:item) #unrelated item
    item_id = create(:item).id
    invoice_item_id = create(:invoice_item, item_id: item_id).id
    get "/api/v1/invoice_items/#{invoice_item_id}/item"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item.class).to eq(Hash)
    expect(item["id"]).to eq(item_id)
    expect(item["name"]).to eq(Item.last.name)
  end
end
