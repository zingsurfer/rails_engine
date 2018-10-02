FactoryBot.define do
  factory :invoice_item do
    invoice { nil }
    item { nil }
    quantity { 1 }
    unit_price { 1.5 }
  end
end
