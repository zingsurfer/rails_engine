FactoryBot.define do
  factory :merchant do
    name { "ThinkGeek" }
    created_at { 2.weeks.ago }
    updated_at { Time.now }
  end
end
