FactoryBot.define do
  factory :customer do
    first_name { "MyString" }
    last_name { "MyString" }
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end
end
