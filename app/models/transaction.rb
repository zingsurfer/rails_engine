class Transaction < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :invoice_id
  validates_presence_of :credit_card_number
  validates_presence_of :result
  validates_presence_of :created_at
  validates_presence_of :updated_at

  scope :success, -> { where(result: "success")}
end
