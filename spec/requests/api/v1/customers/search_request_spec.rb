require 'rails_helper'

describe 'Customers API search' do
  describe 'finds a single customer' do
    it 'by first_first_name' do
      create(:customer) #nonqueried customer
      value = create(:customer, first_name: "Anise").first_name

      get "/api/v1/customers/find?first_name=#{value}"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer.class).to eq(Hash)
      expect(customer["first_name"]).to eq(value)
      expect(customer["id"]).to eq(Customer.last.id)
    end

    it 'by first_first_name' do
      create(:customer) #nonqueried customer
      value = create(:customer, last_name: "Belacova").last_name

      get "/api/v1/customers/find?last_name=#{value}"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer.class).to eq(Hash)
      expect(customer["last_name"]).to eq(value)
      expect(customer["id"]).to eq(Customer.last.id)
    end

    it 'by id' do
      create(:customer) #nonqueried customer
      value = create(:customer).id

      get "/api/v1/customers/find?id=#{value}"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer.class).to eq(Hash)
      expect(customer["id"]).to eq(value)
      expect(customer["first_name"]).to eq(Customer.last.first_name)
    end

    it 'by created_at' do
      create(:customer) #nonqueried customer
      value = create(:customer, created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S")).created_at
      get "/api/v1/customers/find?created_at=#{value}"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer.class).to eq(Hash)
      expect(customer["first_name"]).to eq(Customer.last.first_name)
      expect(customer["id"]).to eq(Customer.last.id)
    end

    it 'by updated_at' do
      create(:customer) #nonqueried customer
      value = create(:customer, updated_at: DateTime.strptime("06-16-2014 00:00:00", "%m-%d-%Y %H:%M:%S")).updated_at

      get "/api/v1/customers/find?updated_at=#{value}"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer.class).to eq(Hash)
      expect(customer["first_name"]).to eq(Customer.last.first_name)
      expect(customer["id"]).to eq(Customer.last.id)
    end
  end

  describe 'finds a multiple customers' do
    it 'by first_name' do
      create(:customer) #nonqueried customer
      queried_customers = create_list(:customer, 2, first_name: "Anise")
      value = queried_customers[0].first_name

      get "/api/v1/customers/find_all?first_name=#{value}"

      customers = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customers.class).to eq(Array)
      expect(customers.count).to eq(2)
      expect(customers[0]["first_name"]).to eq(value)
      expect(customers[1]["first_name"]).to eq(value)
      expect(customers[0]["id"]).to eq(queried_customers[0].id)
      expect(customers[1]["id"]).to eq(queried_customers[1].id)
    end

    it 'by first_name' do
      create(:customer) #nonqueried customer
      queried_customers = create_list(:customer, 2, last_name: "Belacova")
      value = queried_customers[0].last_name

      get "/api/v1/customers/find_all?last_name=#{value}"

      customers = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customers.class).to eq(Array)
      expect(customers.count).to eq(2)
      expect(customers[0]["last_name"]).to eq(value)
      expect(customers[1]["last_name"]).to eq(value)
      expect(customers[0]["id"]).to eq(queried_customers[0].id)
      expect(customers[1]["id"]).to eq(queried_customers[1].id)
    end

    it 'by id' do
      create(:customer) #nonqueried customer
      queried_customer = create(:customer)
      value = queried_customer.id

      get "/api/v1/customers/find_all?id=#{value}"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer.class).to eq(Array)
      expect(customer.count).to eq(1)
      expect(customer[0]["id"]).to eq(value)
      expect(customer[0]["first_name"]).to eq(queried_customer.first_name)
    end

    it 'by created_at' do
      create(:customer) #nonqueried customer
      create_list(:customer, 2, created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S"))
      value = create(:customer, created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S")).created_at
      get "/api/v1/customers/find_all?created_at=#{value}"

      customers = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customers.class).to eq(Array)
      expect(customers.count).to eq(3)
      expect(customers.last["first_name"]).to eq(Customer.last.first_name)
      expect(customers.last["id"]).to eq(Customer.last.id)
    end

    it 'by updated_at' do
      create(:customer) #nonqueried customer
      create_list(:customer, 2, updated_at: DateTime.strptime("06-16-2014 00:00:00", "%m-%d-%Y %H:%M:%S"))
      value = create(:customer, updated_at: DateTime.strptime("06-16-2014 00:00:00", "%m-%d-%Y %H:%M:%S")).updated_at

      get "/api/v1/customers/find_all?updated_at=#{value}"

      customers = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customers.class).to eq(Array)
      expect(customers.count).to eq(3)
      expect(customers.last["first_name"]).to eq(Customer.last.first_name)
      expect(customers.last["id"]).to eq(Customer.last.id)
    end
  end
end
