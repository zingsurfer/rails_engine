require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_merchant(:merchant, 4)

    get '/api/v1/merchants'

    expect(response).to be_successful
  end 
end
