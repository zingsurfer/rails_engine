require 'rails_helper'

describe 'Items API search' do
  describe 'finds a single item' do
    it 'by name' do
      create(:item) #nonqueried item
      value = create(:item, name: "Cat Cafe").name

      get "/api/v1/items/find?name=#{value}"

      item = JSON.parse(response.body)

      expect(item.class).to eq(Hash)
      expect(response).to be_successful
      expect(item["name"]).to eq(value)
      expect(item["id"]).to eq(Item.last.id)
    end

    it 'by id' do
      create(:item) #nonqueried item
      value = create(:item).id

      get "/api/v1/items/find?id=#{value}"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item.class).to eq(Hash)
      expect(item["id"]).to eq(value)
      expect(item["name"]).to eq(Item.last.name)
    end

    it 'by created_at' do
      create(:item) #nonqueried item
      value = create(:item, created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S")).created_at
      get "/api/v1/items/find?created_at=#{value}"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item.class).to eq(Hash)
      expect(item["name"]).to eq(Item.last.name)
      expect(item["id"]).to eq(Item.last.id)
    end

    it 'by updated_at' do
      create(:item) #non_queried item
      value = create(:item, updated_at: DateTime.strptime("06-16-2014 00:00:00", "%m-%d-%Y %H:%M:%S")).updated_at

      get "/api/v1/items/find?updated_at=#{value}"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item.class).to eq(Hash)
      expect(item["name"]).to eq(Item.last.name)
      expect(item["id"]).to eq(Item.last.id)
    end
  end

  describe 'finds a multiple items' do
    it 'by name' do
      create(:item) #nonqueried item
      queried_items = create_list(:item, 2, name: "Cat Cafe")
      value = queried_items[0].name

      get "/api/v1/items/find_all?name=#{value}"

      items = JSON.parse(response.body)

      expect(response).to be_successful
      expect(items.class).to eq(Array)
      expect(items.count).to eq(2)
      expect(items[0]["name"]).to eq(value)
      expect(items[1]["name"]).to eq(value)
      expect(items[0]["id"]).to eq(queried_items[0].id)
      expect(items[1]["id"]).to eq(queried_items[1].id)
    end

    it 'by id' do
      create(:item) #nonqueried item
      queried_item = create(:item)
      value = queried_item.id

      get "/api/v1/items/find_all?id=#{value}"

      item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item.class).to eq(Array)
      expect(item.count).to eq(1)
      expect(item[0]["id"]).to eq(value)
      expect(item[0]["name"]).to eq(queried_item.name)
    end

    it 'by created_at' do
      create(:item) #nonqueried item
      create_list(:item, 2, created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S"))
      value = create(:item, created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S")).created_at
      get "/api/v1/items/find_all?created_at=#{value}"

      items = JSON.parse(response.body)

      expect(response).to be_successful
      expect(items.class).to eq(Array)
      expect(items.count).to eq(3)
      expect(items.last["name"]).to eq(Item.last.name)
      expect(items.last["id"]).to eq(Item.last.id)
    end

    it 'by updated_at' do
      create(:item) #nonqueried item
      create_list(:item, 2, updated_at: DateTime.strptime("06-16-2014 00:00:00", "%m-%d-%Y %H:%M:%S"))
      value = create(:item, updated_at: DateTime.strptime("06-16-2014 00:00:00", "%m-%d-%Y %H:%M:%S")).updated_at

      get "/api/v1/items/find_all?updated_at=#{value}"

      items = JSON.parse(response.body)

      expect(response).to be_successful
      expect(items.class).to eq(Array)
      expect(items.count).to eq(3)
      expect(items.last["name"]).to eq(Item.last.name)
      expect(items.last["id"]).to eq(Item.last.id)
    end
  end
end
