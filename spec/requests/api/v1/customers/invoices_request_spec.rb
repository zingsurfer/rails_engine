require 'rails_helper'

describe 'Customer invoices API' do
  it 'sends a list of invoices for a customer' do
    create(:invoice) #unrelated invoice
    customer_id = create(:customer).id
    invoices = create_list(:invoice, 3, customer_id: customer_id)

    get "/api/v1/customers/#{customer_id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices.count).to eq(3)
    expect(invoices.class).to eq(Array)
    expect(invoices[0]["customer_id"]).to eq(customer_id)
    expect(invoices[1]["customer_id"]).to eq(customer_id)
    expect(invoices[2]["customer_id"]).to eq(customer_id)
  end
end
