require 'rails_helper'

describe 'Merchants API most sold items' do
  it 'returns top merchants' do
    queried_merchants = create_list(:merchant, 6)

    invoices = queried_merchants.map do |merchant|
      create(:invoice, merchant_id: merchant.id)
    end

    invoices.map.with_index do |invoice, index|
      create(:invoice_item, invoice_id: invoice.id, quantity: index + 1)
    end

    invoices.map do |invoice|
      create(:transaction, invoice_id: invoice.id, result: "success")
    end

    x = 3
    get "/api/v1/merchants/most_items?quantity=#{x}"

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.count).to eq(3)
  end
end
