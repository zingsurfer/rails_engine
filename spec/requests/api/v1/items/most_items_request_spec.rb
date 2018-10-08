require 'rails_helper'
# GET /api/v1/items/most_items?quantity=x
#returns the top x item instances ranked by total number sold
describe 'Items API most items' do
  it 'returns top items ranked by total number sold' do
    queried_items = create_list(:item, 4)

    queried_items.map.with_index do |item, index|
      invoice = create(:invoice)
      create(:invoice_item, item: item, invoice: invoice, quantity: index + 2)
      create(:transaction, invoice: invoice, result: "success")
    end

    x = 3
    get "/api/v1/items/most_items?quantity=#{x}"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(3)
    expect(items.class).to eq(Array)
    expect(items.first["id"]).to eq(queried_items[3].id)
    expect(items.last["id"]).to eq(queried_items[1].id)
  end
end
