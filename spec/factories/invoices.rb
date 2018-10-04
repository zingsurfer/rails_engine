FactoryBot.define do
  factory :invoice do
    merchant { create(:merchant) }
    customer { create(:customer) }
    status { "MyString" }
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end
end
