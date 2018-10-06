require 'rails_helper'

describe 'Invoice Customer API' do
  it 'sends the associated customer for an invoice' do
    customer_id = create(:customer).id
    invoice_id = create(:invoice, customer_id: customer_id).id

    get "/api/v1/invoices/#{invoice_id}/customer"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer.class).to eq(Hash)
    expect(customer["id"]).to eq(customer_id)
    expect(customer["first_name"]).to eq(Customer.last.first_name)
  end
end
