require 'rails_helper'

describe 'InvoiceItems API' do
  it 'sends a list of invoice items' do
    create_list(:invoice_item, 4)

    get "/api/v1/invoice_items/"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items.class).to eq(Array)
    expect(invoice_items.count).to eq(4)
  end
  it 'sends a single invoice item' do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item.class).to eq(Hash)
    expect(invoice_item["id"]).to eq(id)
  end
end
