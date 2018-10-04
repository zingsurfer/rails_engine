FactoryBot.define do
  factory :invoice_item do
    invoice { create(:invoice) }
    item { create(:item) }
    quantity { 1 }
    unit_price { 1.5 }
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end
end
