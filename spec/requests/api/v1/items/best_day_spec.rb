require 'rails_helper'
# GET /api/v1/items/:id/best_day
# returns the date with the most sales for the given item using the invoice date.
# If there are multiple days with equal number of sales, return the most recent day.

describe 'Items API best day' do
  it 'returns the best sell day for an item' do
    item = create(:item)
    invoices = create_list(:invoice, 3)
    invoices.map do |invoice|
      create(:invoice_item, item: item, invoice: invoice)
      create(:transaction, invoice: invoice, result: "success", created_at: DateTime.parse("2018-10-07"))
    end

    get "/api/v1/items/#{item.id}/best_day"

    date = JSON.parse(response.body)

    expect(response).to be_successful
    expect(date["best_day"]).to eq("2018-10-07T00:00:00.000Z")
  end
end
