class Item < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :merchant_id,
                        :name,
                        :description,
                        :unit_price,
                        :created_at,
                        :updated_at
end
