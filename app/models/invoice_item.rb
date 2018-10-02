class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  validates_presence_of :invoice_id
  validates_presence_of :item_id
  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :created_at
  validates_presence_of :updated_at
end
