require 'rails_helper'

describe 'InvoiceItems API search' do
  describe 'finds a single invoice_item' do
    it 'by quantity' do
      create(:invoice_item) #nonqueried invoice_item
      value = create(:invoice_item, quantity: 4).quantity

      get "/api/v1/invoice_items/find?quantity=#{value}"

      invoice_item = JSON.parse(response.body)

      expect(invoice_item.class).to eq(Hash)
      expect(response).to be_successful
      expect(invoice_item["quantity"]).to eq(value)
      expect(invoice_item["id"]).to eq(InvoiceItem.last.id)
    end

    it 'by unit_price' do
      create(:invoice_item) #nonqueried invoice_item
      value = create(:invoice_item, unit_price: 5.00).unit_price

      get "/api/v1/invoice_items/find?unit_price=#{value}"

      invoice_item = JSON.parse(response.body)

      expect(invoice_item.class).to eq(Hash)
      expect(response).to be_successful
      expect(invoice_item["unit_price"].to_f).to eq(value)
      expect(invoice_item["id"]).to eq(InvoiceItem.last.id)
    end

    it 'by id' do
      create(:invoice_item) #nonqueried invoice_item
      value = create(:invoice_item).id

      get "/api/v1/invoice_items/find?id=#{value}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item.class).to eq(Hash)
      expect(invoice_item["id"]).to eq(value)
      expect(invoice_item["quantity"]).to eq(InvoiceItem.last.quantity)
    end

    it 'by invoice_id' do
      invoice = create(:invoice)
      value = create(:invoice_item, invoice: invoice).invoice_id

      get "/api/v1/invoice_items/find?invoice_id=#{value}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item.class).to eq(Hash)
      expect(invoice_item["invoice_id"]).to eq(InvoiceItem.last.invoice_id)
      expect(invoice_item["id"]).to eq(InvoiceItem.last.id)
    end

    it 'by item_id' do
      item = create(:item)
      value = create(:invoice_item, item: item).item_id

      get "/api/v1/invoice_items/find?item_id=#{value}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item.class).to eq(Hash)
      expect(invoice_item["item_id"]).to eq(value)
      expect(invoice_item["id"]).to eq(InvoiceItem.last.id)
    end

    it 'by created_at' do
      create(:invoice_item) #nonqueried invoice_item
      value = create(:invoice_item, created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S")).created_at
      get "/api/v1/invoice_items/find?created_at=#{value}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item.class).to eq(Hash)
      expect(invoice_item["quantity"]).to eq(InvoiceItem.last.quantity)
      expect(invoice_item["id"]).to eq(InvoiceItem.last.id)
    end

    it 'by updated_at' do
      create(:invoice_item) #non_queried invoice_item
      value = create(:invoice_item, updated_at: DateTime.strptime("06-16-2014 00:00:00", "%m-%d-%Y %H:%M:%S")).updated_at

      get "/api/v1/invoice_items/find?updated_at=#{value}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item.class).to eq(Hash)
      expect(invoice_item["quantity"]).to eq(InvoiceItem.last.quantity)
      expect(invoice_item["id"]).to eq(InvoiceItem.last.id)
    end
  end

  describe 'finds a multiple invoice_items' do
    it 'by quantity' do
      create(:invoice_item) #nonqueried invoice_item
      queried_invoice_items = create_list(:invoice_item, 2, quantity: "Cat Cafe")
      value = queried_invoice_items[0].quantity

      get "/api/v1/invoice_items/find_all?quantity=#{value}"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_items.class).to eq(Array)
      expect(invoice_items.count).to eq(2)
      expect(invoice_items[0]["quantity"]).to eq(value)
      expect(invoice_items[1]["quantity"]).to eq(value)
      expect(invoice_items[0]["id"]).to eq(queried_invoice_items[0].id)
      expect(invoice_items[1]["id"]).to eq(queried_invoice_items[1].id)
    end

    it 'by id' do
      create(:invoice_item) #nonqueried invoice_item
      queried_invoice_item = create(:invoice_item)
      value = queried_invoice_item.id

      get "/api/v1/invoice_items/find_all?id=#{value}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item.class).to eq(Array)
      expect(invoice_item.count).to eq(1)
      expect(invoice_item[0]["id"]).to eq(value)
      expect(invoice_item[0]["quantity"]).to eq(queried_invoice_item.quantity)
    end

    it 'by invoice_id' do
      invoice = create(:invoice)
      create_list(:invoice_item, 2, invoice: invoice)
      queried_invoice_item = create(:invoice_item, invoice: invoice)
      value = queried_invoice_item.invoice_id

      get "/api/v1/invoice_items/find_all?invoice_id=#{value}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item.class).to eq(Array)
      expect(invoice_item.count).to eq(3)
      expect(invoice_item[0]["invoice_id"]).to eq(value)
      expect(invoice_item[0]["quantity"]).to eq(queried_invoice_item.quantity)
    end

    it 'by item_id' do
      item = create(:item)
      create_list(:invoice_item, 2, item: item)
      queried_invoice_item = create(:invoice_item, item: item)
      value = queried_invoice_item.item_id

      get "/api/v1/invoice_items/find_all?item_id=#{value}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item.class).to eq(Array)
      expect(invoice_item.count).to eq(3)
      expect(invoice_item[0]["item_id"]).to eq(value)
      expect(invoice_item[0]["quantity"]).to eq(queried_invoice_item.quantity)
    end

    it 'by unit_price' do
      create_list(:invoice_item, 2, unit_price: 4.50)
      queried_invoice_item = create(:invoice_item, unit_price: 4.50)
      value = queried_invoice_item.unit_price

      get "/api/v1/invoice_items/find_all?unit_price=#{value}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item.class).to eq(Array)
      expect(invoice_item.count).to eq(3)
      expect(invoice_item[0]["unit_price"].to_f).to eq(value)
      expect(invoice_item[0]["quantity"]).to eq(queried_invoice_item.quantity)
    end

    it 'by created_at' do
      create(:invoice_item) #nonqueried invoice_item
      create_list(:invoice_item, 2, created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S"))
      value = create(:invoice_item, created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S")).created_at
      get "/api/v1/invoice_items/find_all?created_at=#{value}"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_items.class).to eq(Array)
      expect(invoice_items.count).to eq(3)
      expect(invoice_items.last["quantity"]).to eq(InvoiceItem.last.quantity)
      expect(invoice_items.last["id"]).to eq(InvoiceItem.last.id)
    end

    it 'by updated_at' do
      create(:invoice_item) #nonqueried invoice_item
      create_list(:invoice_item, 2, updated_at: DateTime.strptime("06-16-2014 00:00:00", "%m-%d-%Y %H:%M:%S"))
      value = create(:invoice_item, updated_at: DateTime.strptime("06-16-2014 00:00:00", "%m-%d-%Y %H:%M:%S")).updated_at

      get "/api/v1/invoice_items/find_all?updated_at=#{value}"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_items.class).to eq(Array)
      expect(invoice_items.count).to eq(3)
      expect(invoice_items.last["quantity"]).to eq(InvoiceItem.last.quantity)
      expect(invoice_items.last["id"]).to eq(InvoiceItem.last.id)
    end
  end
end
