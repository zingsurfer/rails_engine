require 'rails_helper'
# GET /api/v1/items/most_revenue?quantity=x
# returns the top x items ranked by total revenue generated
describe 'Items API most revenue' do
  it 'returns top items ranked by revenue' do
    queried_items = create_list(:item, 4)

    queried_items.map.with_index do |item, index|
      invoice = create(:invoice)
      create(:invoice_item, item: item, invoice: invoice, unit_price: index + 10)
      create(:transaction, invoice: invoice)
    end

    x = 3
    get "/api/v1/items/most_revenue?quantity=#{x}"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.first["id"]).to be(queried_items[3].id)
  end
end
