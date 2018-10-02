class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer

  validates_presence_of :status,
                        :created_at,
                        :updated_at,
                        :merchant_id,
                        :customer_id
end
