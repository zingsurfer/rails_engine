FactoryBot.define do
  factory :item do
    merchant { create(:merchant) }
    name { "MyString" }
    description { "MyText" }
    unit_price { 1.5 }
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end
end
