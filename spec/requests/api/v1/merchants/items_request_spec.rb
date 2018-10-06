require 'rails_helper'

describe 'Merchant Items API' do
  it 'sends a list of merchant items' do
    merchant = create(:merchant)
    item_1, item_2, item_3 = create_list(:item, 3, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)
    create(:item) # unrelated item
    
    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.class).to eq(Array)
    expect(items.count).to eq(3)
    expect(items[0]["id"]).to eq(item_1.id)
    expect(items[1]["id"]).to eq(item_2.id)
    expect(items[2]["id"]).to eq(item_3.id)
  end
end
