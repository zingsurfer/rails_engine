require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    create_list(:item, 4)

    get '/api/v1/items'

    items = JSON.parse(response.body)
    
    expect(response).to be_successful
    expect(items.count).to eq(4)
  end
  it 'sends one item via its id' do
  end
end
