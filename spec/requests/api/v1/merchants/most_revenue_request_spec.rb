require 'rails_helper'

describe 'Merchants API most revenue' do
  # GET /api/v1/merchants/most_revenue?quantity=x returns the top x merchants ranked by total revenue
  xit 'returns top merchants' do
    create_list(:merchant, 4)
    name = create(:merchant).name
    x = 1
    get "/api/v1/merchants/most_revenue?quantity=#{x}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["name"]).to eq(name)
  end
end
