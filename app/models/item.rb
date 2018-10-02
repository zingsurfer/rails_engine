class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :merchant_id,
                        :name,
                        :description,
                        :unit_price,
                        :created_at,
                        :updated_at
end
