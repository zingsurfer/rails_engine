require 'rails_helper'

describe 'Merchants API most revenue' do
  # GET /api/v1/merchants/most_revenue?quantity=x returns the top x merchants ranked by total revenue
  it 'returns top merchants' do

    merchants = create_list(:merchant, 6)

    invoices = merchants.map do |merchant|
      create(:invoice, merchant_id: merchant.id)
    end

    invoice_items = invoices.map.with_index do |invoice, index|
      create(:invoice_item, invoice_id: invoice.id, quantity: index + 1)
    end

    transactions = invoices.map.with_index do |invoice, index|
      create(:transaction, invoice_id: invoice.id, result: "success")
    end

    failed_transaction = create(:transaction, invoice_id: invoices[3].id, result: "failed")

    x = 3
    get "/api/v1/merchants/most_revenue?quantity=#{x}"

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.count).to eq(3)
  end
end
