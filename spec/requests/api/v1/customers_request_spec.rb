require 'rails_helper'

describe 'Customers API' do
  it 'sends a list of customers' do
    create_list(:customer, 4)

    get "/api/v1/customers/"

    customers = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customers.class).to eq(Array)
    expect(customers.count).to eq(4)
  end
  it 'sends a single customer' do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer.class).to eq(Hash)
    expect(customer["id"]).to eq(id)
  end
end
