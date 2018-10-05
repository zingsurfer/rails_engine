require 'rails_helper'

describe 'Invoices API' do
  it 'sends a list of invoices' do
    create_list(:invoice, 4)

    get '/api/v1/invoices'

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices.class).to eq(Array)
    expect(invoices.count).to eq(4)
  end
  it 'sends one invoice via its id' do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice.class).to eq(Hash)
    expect(invoice["id"]).to eq(id)
  end
end
