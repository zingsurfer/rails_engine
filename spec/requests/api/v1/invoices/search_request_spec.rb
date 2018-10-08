require 'rails_helper'

describe 'Invoices API search' do
  describe 'finds a single invoice' do
    it 'by customer_id' do
      create(:invoice) #nonqueried invoice
      customer = create(:customer)
      value = create(:invoice, customer: customer).customer_id

      get "/api/v1/invoices/find?customer_id=#{value}"

      invoice = JSON.parse(response.body)

      expect(invoice.class).to eq(Hash)
      expect(response).to be_successful
      expect(invoice["customer_id"]).to eq(value)
      expect(invoice["id"]).to eq(Invoice.last.id)
    end
    it 'by merchant_id' do
      create(:invoice) #nonqueried invoice
      merchant = create(:merchant)
      value = create(:invoice, merchant: merchant).merchant_id

      get "/api/v1/invoices/find?merchant_id=#{value}"

      invoice = JSON.parse(response.body)

      expect(invoice.class).to eq(Hash)
      expect(response).to be_successful
      expect(invoice["merchant_id"]).to eq(value)
      expect(invoice["id"]).to eq(Invoice.last.id)
    end

    it 'by id' do
      create(:invoice) #nonqueried invoice
      value = create(:invoice).id

      get "/api/v1/invoices/find?id=#{value}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice.class).to eq(Hash)
      expect(invoice["id"]).to eq(value)
      expect(invoice["customer_id"]).to eq(Invoice.last.customer_id)
    end

    it 'by status' do
      create(:invoice, status: "different") #nonqueried invoice
      value = create(:invoice).status

      get "/api/v1/invoices/find?status=#{value}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice.class).to eq(Hash)
      expect(invoice["status"]).to eq(value)
      expect(invoice["customer_id"]).to eq(Invoice.last.customer_id)
    end

    it 'by created_at' do
      create(:invoice) #nonqueried invoice
      value = create(:invoice, created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S")).created_at
      get "/api/v1/invoices/find?created_at=#{value}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice.class).to eq(Hash)
      expect(invoice["customer_id"]).to eq(Invoice.last.customer_id)
      expect(invoice["id"]).to eq(Invoice.last.id)
    end

    it 'by updated_at' do
      create(:invoice) #non_queried invoice
      value = create(:invoice, updated_at: DateTime.strptime("06-16-2014 00:00:00", "%m-%d-%Y %H:%M:%S")).updated_at

      get "/api/v1/invoices/find?updated_at=#{value}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice.class).to eq(Hash)
      expect(invoice["customer_id"]).to eq(Invoice.last.customer_id)
      expect(invoice["id"]).to eq(Invoice.last.id)
    end
  end

  describe 'finds a multiple invoices' do
    it 'by customer_id' do
      create(:invoice) #nonqueried invoice
      customer = create(:customer)
      queried_invoices = create_list(:invoice, 2, customer: customer)
      value = queried_invoices[0].customer_id

      get "/api/v1/invoices/find_all?customer_id=#{value}"

      invoices = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoices.class).to eq(Array)
      expect(invoices.count).to eq(2)
      expect(invoices[0]["customer_id"]).to eq(value)
      expect(invoices[1]["customer_id"]).to eq(value)
      expect(invoices[0]["id"]).to eq(queried_invoices[0].id)
      expect(invoices[1]["id"]).to eq(queried_invoices[1].id)
    end

    it 'by merchant_id' do
      create(:invoice) #nonqueried invoice
      merchant = create(:merchant)
      queried_invoices = create_list(:invoice, 2, merchant: merchant)
      value = queried_invoices[0].merchant_id

      get "/api/v1/invoices/find_all?merchant_id=#{value}"

      invoices = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoices.class).to eq(Array)
      expect(invoices.count).to eq(2)
      expect(invoices[0]["merchant_id"]).to eq(value)
      expect(invoices[1]["merchant_id"]).to eq(value)
      expect(invoices[0]["id"]).to eq(queried_invoices[0].id)
      expect(invoices[1]["id"]).to eq(queried_invoices[1].id)
    end

    it 'by id' do
      create(:invoice) #nonqueried invoice
      queried_invoice = create(:invoice)
      value = queried_invoice.id

      get "/api/v1/invoices/find_all?id=#{value}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice.class).to eq(Array)
      expect(invoice.count).to eq(1)
      expect(invoice[0]["id"]).to eq(value)
      expect(invoice[0]["customer_id"]).to eq(queried_invoice.customer_id)
    end

    it 'by status' do
      create(:invoice, status: "different") #nonqueried invoice
      queried_invoice = create(:invoice)
      value = queried_invoice.status

      get "/api/v1/invoices/find_all?status=#{value}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice.class).to eq(Array)
      expect(invoice.count).to eq(1)
      expect(invoice[0]["status"]).to eq(value)
      expect(invoice[0]["id"]).to eq(queried_invoice.id)
    end

    it 'by created_at' do
      create(:invoice) #nonqueried invoice
      create_list(:invoice, 2, created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S"))
      value = create(:invoice, created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S")).created_at
      get "/api/v1/invoices/find_all?created_at=#{value}"

      invoices = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoices.class).to eq(Array)
      expect(invoices.count).to eq(3)
      expect(invoices.last["customer_id"]).to eq(Invoice.last.customer_id)
      expect(invoices.last["id"]).to eq(Invoice.last.id)
    end

    it 'by updated_at' do
      create(:invoice) #nonqueried invoice
      create_list(:invoice, 2, updated_at: DateTime.strptime("06-16-2014 00:00:00", "%m-%d-%Y %H:%M:%S"))
      value = create(:invoice, updated_at: DateTime.strptime("06-16-2014 00:00:00", "%m-%d-%Y %H:%M:%S")).updated_at

      get "/api/v1/invoices/find_all?updated_at=#{value}"

      invoices = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoices.class).to eq(Array)
      expect(invoices.count).to eq(3)
      expect(invoices.last["customer_id"]).to eq(Invoice.last.customer_id)
      expect(invoices.last["id"]).to eq(Invoice.last.id)
    end
  end
end
