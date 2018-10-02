FactoryBot.define do
  factory :item do
    merchant { nil }
    name { "MyString" }
    description { "MyText" }
    unit_price { 1.5 }
  end
end
