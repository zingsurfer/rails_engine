require 'rails_helper'

describe 'Merchants API search' do
  describe 'finds a single merchant' do

    it 'by name' do
      create_list(:merchant, 4)
      value = create(:merchant).name

      get "/api/v1/merchants/find?name=#{value}"


      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["name"]).to eq(value)
    end
    it 'by id' do
      create_list(:merchant, 4)
      value = create(:merchant).id

      get "/api/v1/merchants/find?id=#{value}"


      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["id"]).to eq(value)
    end
    it 'by created_at' do
      value = Merchant.create!(name: "Betty", created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S" )).created_at
      get "/api/v1/merchants/find?created_at=#{value}"


      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["created_at"]).to eq(value)
    end
    it 'by updated_at' do
      create_list(:merchant, 4)
      value = create(:merchant).updated_at

      get "/api/v1/merchants/find?updated_at=#{value}"


      merchant = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchant["updated_at"]).to eq(value)
    end
  end

end
