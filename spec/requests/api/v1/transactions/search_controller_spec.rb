require 'rails_helper'

describe 'Transactions API search' do
  describe 'finds a single transaction' do
    it 'by credit_card_number' do
      create(:transaction) #nonqueried transaction
      value = create(:transaction, credit_card_number: "1234").credit_card_number

      get "/api/v1/transactions/find?credit_card_number=#{value}"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction.class).to eq(Hash)
      expect(transaction["credit_card_number"]).to eq(value)
      expect(transaction["id"]).to eq(Transaction.last.id)
    end

    it 'by credit_card_expiration_date' do
      create(:transaction) #nonqueried transaction
      value = create(:transaction, credit_card_expiration_date: "122017").credit_card_expiration_date

      get "/api/v1/transactions/find?credit_card_expiration_date=#{value}"

      transaction = JSON.parse(response.body)
      
      expect(response).to be_successful
      expect(transaction.class).to eq(Hash)
      expect(transaction["credit_card_expiration_date"]).to eq(value)
      expect(transaction["id"]).to eq(Transaction.last.id)
    end

    it 'by id' do
      create(:transaction) #nonqueried transaction
      value = create(:transaction).id

      get "/api/v1/transactions/find?id=#{value}"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction.class).to eq(Hash)
      expect(transaction["id"]).to eq(value)
      expect(transaction["credit_card_number"]).to eq(Transaction.last.credit_card_number)
    end

    it 'by created_at' do
      create(:transaction) #nonqueried transaction
      value = create(:transaction, created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S")).created_at
      get "/api/v1/transactions/find?created_at=#{value}"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction.class).to eq(Hash)
      expect(transaction["credit_card_number"]).to eq(Transaction.last.credit_card_number)
      expect(transaction["id"]).to eq(Transaction.last.id)
    end

    it 'by updated_at' do
      create(:transaction) #nonqueried transaction
      value = create(:transaction, updated_at: DateTime.strptime("06-16-2014 00:00:00", "%m-%d-%Y %H:%M:%S")).updated_at

      get "/api/v1/transactions/find?updated_at=#{value}"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction.class).to eq(Hash)
      expect(transaction["credit_card_number"]).to eq(Transaction.last.credit_card_number)
      expect(transaction["id"]).to eq(Transaction.last.id)
    end
  end

  describe 'finds a multiple transactions' do
    it 'by credit_card_number' do
      create(:transaction) #nonqueried transaction
      queried_transactions = create_list(:transaction, 2, credit_card_number: "1234")
      value = queried_transactions[0].credit_card_number

      get "/api/v1/transactions/find_all?credit_card_number=#{value}"

      transactions = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transactions.class).to eq(Array)
      expect(transactions.count).to eq(2)
      expect(transactions[0]["credit_card_number"]).to eq(value)
      expect(transactions[1]["credit_card_number"]).to eq(value)
      expect(transactions[0]["id"]).to eq(queried_transactions[0].id)
      expect(transactions[1]["id"]).to eq(queried_transactions[1].id)
    end

    it 'by credit_card_expiration_date' do
      create(:transaction) #nonqueried transaction
      queried_transactions = create_list(:transaction, 2, credit_card_expiration_date: "122015")
      value = queried_transactions[0].credit_card_expiration_date

      get "/api/v1/transactions/find_all?credit_card_expiration_date=#{value}"

      transactions = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transactions.class).to eq(Array)
      expect(transactions.count).to eq(2)
      expect(transactions[0]["credit_card_expiration_date"]).to eq(value)
      expect(transactions[1]["credit_card_expiration_date"]).to eq(value)
      expect(transactions[0]["id"]).to eq(queried_transactions[0].id)
      expect(transactions[1]["id"]).to eq(queried_transactions[1].id)
    end

    it 'by id' do
      create(:transaction) #nonqueried transaction
      queried_transaction = create(:transaction)
      value = queried_transaction.id

      get "/api/v1/transactions/find_all?id=#{value}"

      transaction = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transaction.class).to eq(Array)
      expect(transaction.count).to eq(1)
      expect(transaction[0]["id"]).to eq(value)
      expect(transaction[0]["credit_card_number"]).to eq(queried_transaction.credit_card_number)
    end

    it 'by created_at' do
      create(:transaction) #nonqueried transaction
      create_list(:transaction, 2, created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S"))
      value = create(:transaction, created_at: DateTime.strptime("01-29-2011 00:00:00", "%m-%d-%Y %H:%M:%S")).created_at
      get "/api/v1/transactions/find_all?created_at=#{value}"

      transactions = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transactions.class).to eq(Array)
      expect(transactions.count).to eq(3)
      expect(transactions.last["credit_card_number"]).to eq(Transaction.last.credit_card_number)
      expect(transactions.last["id"]).to eq(Transaction.last.id)
    end

    it 'by updated_at' do
      create(:transaction) #nonqueried transaction
      create_list(:transaction, 2, updated_at: DateTime.strptime("06-16-2014 00:00:00", "%m-%d-%Y %H:%M:%S"))
      value = create(:transaction, updated_at: DateTime.strptime("06-16-2014 00:00:00", "%m-%d-%Y %H:%M:%S")).updated_at

      get "/api/v1/transactions/find_all?updated_at=#{value}"

      transactions = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transactions.class).to eq(Array)
      expect(transactions.count).to eq(3)
      expect(transactions.last["credit_card_number"]).to eq(Transaction.last.credit_card_number)
      expect(transactions.last["id"]).to eq(Transaction.last.id)
    end
  end
end
