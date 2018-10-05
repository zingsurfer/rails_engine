require 'rails_helper'

describe 'MerchantItems API' do
  it 'sends a list of merchant items' do
    merchant = create(:merchant)
    items = create_list(:item, 3, merchant_id: merchant.id, created_at: Time.now, updated_at: Time.now)

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.class).to eq(Array)
    expect(items.count).to eq(3)
  end
end
