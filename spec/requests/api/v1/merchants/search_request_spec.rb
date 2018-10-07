require 'rails_helper'

describe 'Merchants API search' do
  describe 'finds a single merchant' do
    it 'by name' do
      create_list(:merchant, 4)
      value = create(:merchant, name: "Cat Cafe").name

      get "/api/v1/merchants/find?name=#{value}"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["name"]).to eq(value)
      expect(merchant["id"]).to eq(Merchant.last.id)
    end

    it 'by id' do
      create_list(:merchant, 4)
      value = create(:merchant).id

      get "/api/v1/merchants/find?id=#{value}"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["id"]).to eq(value)
      expect(merchant["name"]).to eq(Merchant.last.name)
    end

    it 'by created_at' do
      value = Merchant.create!(name: "Betty", created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S")).created_at
      get "/api/v1/merchants/find?created_at=#{value}"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["name"]).to eq(Merchant.last.name)
      expect(merchant["id"]).to eq(Merchant.last.id)
    end

    it 'by updated_at' do
      create_list(:merchant, 4)
      value = create(:merchant, updated_at: DateTime.strptime("06-16-2014 00:00:00", "%m-%d-%Y %H:%M:%S")).updated_at

      get "/api/v1/merchants/find?updated_at=#{value}"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["name"]).to eq(Merchant.last.name)
      expect(merchant["id"]).to eq(Merchant.last.id)
    end
  end

  describe 'finds a multiple merchants' do
    it 'by name' do
      create_list(:merchant, 1)
      queried_merchants = create_list(:merchant, 2, name: "Cat Cafe")
      value = queried_merchants[0].name

      get "/api/v1/merchants/find_all?name=#{value}"

      merchants = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants.class).to eq(Array)
      expect(merchants.count).to eq(2)
      expect(merchants[0]["name"]).to eq(value)
      expect(merchants[1]["name"]).to eq(value)
      expect(merchants[0]["id"]).to eq(queried_merchants[0].id)
      expect(merchants[1]["id"]).to eq(queried_merchants[1].id)
    end

    it 'by id' do
      create_list(:merchant, 1)
      queried_merchant = create(:merchant)
      value = queried_merchant.id

      get "/api/v1/merchants/find_all?id=#{value}"

      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant.class).to eq(Array)
      expect(merchant.count).to eq(1)
      expect(merchant[0]["id"]).to eq(value)
      expect(merchant[0]["name"]).to eq(queried_merchant.name)
    end

  #   it 'by created_at' do
  #     value = Merchant.create!(name: "Betty", created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S")).created_at
  #     get "/api/v1/merchants/find_all?created_at=#{value}"
  #
  #     merchant = JSON.parse(response.body)
  #
  #     expect(response).to be_successful
  #     expect(merchant["name"]).to eq(Merchant.last.name)
  #     expect(merchant["id"]).to eq(Merchant.last.id)
  #   end
  #
  #   it 'by updated_at' do
  #     create_list(:merchant, 4)
  #     value = create(:merchant, updated_at: DateTime.strptime("06-16-2014 00:00:00", "%m-%d-%Y %H:%M:%S")).updated_at
  #
  #     get "/api/v1/merchants/find_all?updated_at=#{value}"
  #
  #     merchant = JSON.parse(response.body)
  #
  #     expect(response).to be_successful
  #     expect(merchant["name"]).to eq(Merchant.last.name)
  #     expect(merchant["id"]).to eq(Merchant.last.id)
  #   end
  end

end
