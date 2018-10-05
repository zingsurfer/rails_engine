require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    create_list(:item, 4)

    get '/api/v1/items'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(4)
    expect(items.class).to eq(Array)
  end
  it 'sends one item via its id' do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(item.class).to eq(Hash)
    expect(response).to be_successful
    expect(item["id"]).to eq(id)
  end
end
