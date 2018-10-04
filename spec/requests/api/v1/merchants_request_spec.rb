require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 4)

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.class).to eq(Array)
    expect(merchants.count).to eq(4)
  end
  it 'sends one merchant via its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(merchant.class).to eq(Hash)
    expect(merchant["id"]).to eq(id)
    expect(response).to be_successful
  end
end
